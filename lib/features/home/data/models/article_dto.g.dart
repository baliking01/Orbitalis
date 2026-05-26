// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => ArticleDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      summary: json['summary'] as String,
      url: json['url'] as String,
      newsSite: json['news_site'] as String,
      publishedAt: json['published_at'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ArticleDtoToJson(ArticleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'url': instance.url,
      'news_site': instance.newsSite,
      'published_at': instance.publishedAt,
      'image_url': instance.imageUrl,
    };

ArticleListResponseDto _$ArticleListResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ArticleListResponseDto(
      results: (json['results'] as List<dynamic>)
          .map((e) => ArticleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
    );

Map<String, dynamic> _$ArticleListResponseDtoToJson(
        ArticleListResponseDto instance) =>
    <String, dynamic>{
      'results': instance.results,
      'next': instance.next,
    };
