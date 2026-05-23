import 'package:json_annotation/json_annotation.dart';

part 'article_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ArticleDto {
  const ArticleDto({
    required this.id,
    required this.title,
    required this.summary,
    required this.url,
    required this.newsSite,
    required this.publishedAt,
    this.imageUrl,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleDtoFromJson(json);

  final int id;
  final String title;
  final String summary;
  final String url;
  final String newsSite;
  final String publishedAt;
  final String? imageUrl;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ArticleListResponseDto {
  const ArticleListResponseDto({required this.results, this.next});

  factory ArticleListResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ArticleListResponseDtoFromJson(json);

  final List<ArticleDto> results;
  final String? next;
}
