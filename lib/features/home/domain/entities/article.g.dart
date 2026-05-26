// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      summary: json['summary'] as String,
      url: json['url'] as String,
      newsSite: json['newsSite'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'url': instance.url,
      'newsSite': instance.newsSite,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };
