// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFeedCollection on Isar {
  IsarCollection<Feed> get feeds => this.collection();
}

const FeedSchema = CollectionSchema(
  name: r'Feed',
  id: 8879644747771893978,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'feedName': PropertySchema(
      id: 2,
      name: r'feedName',
      type: IsarType.string,
    ),
    r'feedUrl': PropertySchema(
      id: 3,
      name: r'feedUrl',
      type: IsarType.string,
    ),
    r'fullText': PropertySchema(
      id: 4,
      name: r'fullText',
      type: IsarType.bool,
    ),
    r'openType': PropertySchema(
      id: 5,
      name: r'openType',
      type: IsarType.long,
    )
  },
  estimateSize: _feedEstimateSize,
  serialize: _feedSerialize,
  deserialize: _feedDeserialize,
  deserializeProp: _feedDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _feedGetId,
  getLinks: _feedGetLinks,
  attach: _feedAttach,
  version: '3.1.0+1',
);

int _feedEstimateSize(
  Feed object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.feedName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.feedUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _feedSerialize(
  Feed object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.description);
  writer.writeString(offsets[2], object.feedName);
  writer.writeString(offsets[3], object.feedUrl);
  writer.writeBool(offsets[4], object.fullText);
  writer.writeLong(offsets[5], object.openType);
}

Feed _feedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Feed(
    category: reader.readStringOrNull(offsets[0]),
    description: reader.readStringOrNull(offsets[1]),
    feedName: reader.readStringOrNull(offsets[2]),
    feedUrl: reader.readStringOrNull(offsets[3]),
    fullText: reader.readBoolOrNull(offsets[4]),
    openType: reader.readLongOrNull(offsets[5]),
  );
  object.id = id;
  return object;
}

P _feedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _feedGetId(Feed object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _feedGetLinks(Feed object) {
  return [];
}

void _feedAttach(IsarCollection<dynamic> col, Id id, Feed object) {
  object.id = id;
}

extension FeedQueryWhereSort on QueryBuilder<Feed, Feed, QWhere> {
  QueryBuilder<Feed, Feed, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FeedQueryWhere on QueryBuilder<Feed, Feed, QWhereClause> {
  QueryBuilder<Feed, Feed, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Feed, Feed, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Feed, Feed, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Feed, Feed, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FeedQueryFilter on QueryBuilder<Feed, Feed, QFilterCondition> {
  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'feedName',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'feedName',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'feedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'feedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'feedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'feedName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedName',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'feedName',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'feedUrl',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'feedUrl',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'feedUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'feedUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'feedUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'feedUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'feedUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'feedUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'feedUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'feedUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> feedUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'feedUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> fullTextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullText',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> fullTextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullText',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> fullTextEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullText',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> openTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openType',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> openTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openType',
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> openTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openType',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> openTypeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openType',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> openTypeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openType',
        value: value,
      ));
    });
  }

  QueryBuilder<Feed, Feed, QAfterFilterCondition> openTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FeedQueryObject on QueryBuilder<Feed, Feed, QFilterCondition> {}

extension FeedQueryLinks on QueryBuilder<Feed, Feed, QFilterCondition> {}

extension FeedQuerySortBy on QueryBuilder<Feed, Feed, QSortBy> {
  QueryBuilder<Feed, Feed, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByFeedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedName', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByFeedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedName', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByFeedUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedUrl', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByFeedUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedUrl', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByOpenType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openType', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> sortByOpenTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openType', Sort.desc);
    });
  }
}

extension FeedQuerySortThenBy on QueryBuilder<Feed, Feed, QSortThenBy> {
  QueryBuilder<Feed, Feed, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByFeedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedName', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByFeedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedName', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByFeedUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedUrl', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByFeedUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'feedUrl', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByOpenType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openType', Sort.asc);
    });
  }

  QueryBuilder<Feed, Feed, QAfterSortBy> thenByOpenTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openType', Sort.desc);
    });
  }
}

extension FeedQueryWhereDistinct on QueryBuilder<Feed, Feed, QDistinct> {
  QueryBuilder<Feed, Feed, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Feed, Feed, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Feed, Feed, QDistinct> distinctByFeedName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'feedName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Feed, Feed, QDistinct> distinctByFeedUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'feedUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Feed, Feed, QDistinct> distinctByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullText');
    });
  }

  QueryBuilder<Feed, Feed, QDistinct> distinctByOpenType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openType');
    });
  }
}

extension FeedQueryProperty on QueryBuilder<Feed, Feed, QQueryProperty> {
  QueryBuilder<Feed, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Feed, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Feed, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Feed, String?, QQueryOperations> feedNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'feedName');
    });
  }

  QueryBuilder<Feed, String?, QQueryOperations> feedUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'feedUrl');
    });
  }

  QueryBuilder<Feed, bool?, QQueryOperations> fullTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullText');
    });
  }

  QueryBuilder<Feed, int?, QQueryOperations> openTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openType');
    });
  }
}
