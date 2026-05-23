import 'package:orbitalis/features/home/data/news_remote_source.dart';
import 'package:orbitalis/features/home/domain/entities/article.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_providers.g.dart';

@riverpod
Future<List<Article>> spaceNews(SpaceNewsRef ref) async {
  final source = ref.watch(newsRemoteSourceProvider);
  final result = await source.getArticles();
  if (result.error != null) throw result.error!;
  return result.data!;
}
