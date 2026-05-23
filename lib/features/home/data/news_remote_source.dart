import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/errors/app_exception.dart';
import 'package:orbitalis/core/network/dio_provider.dart';
import 'package:orbitalis/core/services/hive_service.dart';
import 'package:orbitalis/features/home/data/models/article_dto.dart';
import 'package:orbitalis/features/home/domain/entities/article.dart';
import 'package:orbitalis/shared/models/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'news_remote_source.g.dart';

@Riverpod(keepAlive: true)
NewsRemoteSource newsRemoteSource(NewsRemoteSourceRef ref) =>
    NewsRemoteSource(ref.watch(dioProvider));

class NewsRemoteSource {
  const NewsRemoteSource(this._dio);

  final Dio _dio;

  static const _cacheKey = 'articles_cache';
  static const _lastFetchKey = 'articles_last_fetch';

  Future<Result<List<Article>>> getArticles({int offset = 0}) async {
    if (offset == 0) {
      final cached = _fromCache();
      if (cached != null) return success(cached);
    }
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${AppConstants.spaceNewsBaseUrl}articles/',
        queryParameters: {
          'limit': AppConstants.newsPageSize,
          'offset': offset,
        },
      );
      if (response.data == null) {
        return failure(const ParseException('Empty news response'));
      }
      final dto = ArticleListResponseDto.fromJson(response.data!);
      final articles = dto.results.map(_dtoToEntity).toList();
      if (offset == 0) await _toCache(articles);
      return success(articles);
    } on DioException catch (e) {
      final cached = _fromCache();
      if (cached != null) return success(cached);
      return failure(NetworkException(e.message ?? 'News fetch failed'));
    } catch (e) {
      return failure(UnknownException(e.toString()));
    }
  }

  List<Article>? _fromCache() {
    final raw = HiveService.articles.get(_cacheKey);
    if (raw == null) return null;
    final lastRaw = HiveService.metadata.get(_lastFetchKey) as String?;
    if (lastRaw != null) {
      final last = DateTime.tryParse(lastRaw);
      if (last != null &&
          DateTime.now().difference(last) < AppConstants.newsCacheDuration) {
        final list = jsonDecode(raw) as List<dynamic>;
        return list
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return null;
  }

  Future<void> _toCache(List<Article> articles) async {
    await HiveService.articles.put(
      _cacheKey,
      jsonEncode(articles.map((a) => a.toJson()).toList()),
    );
    await HiveService.metadata.put(
      _lastFetchKey,
      DateTime.now().toIso8601String(),
    );
  }

  Article _dtoToEntity(ArticleDto d) => Article(
        id: d.id,
        title: d.title,
        summary: d.summary,
        url: d.url,
        newsSite: d.newsSite,
        publishedAt: DateTime.parse(d.publishedAt),
        imageUrl: d.imageUrl,
      );
}
