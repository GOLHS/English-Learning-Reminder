// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verb_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVerbCollection on Isar {
  IsarCollection<Verb> get verbs => this.collection();
}

const VerbSchema = CollectionSchema(
  name: r'Verb',
  id: 7259430173684739174,
  properties: {
    r'baseForm': PropertySchema(
      id: 0,
      name: r'baseForm',
      type: IsarType.string,
    ),
    r'consecutiveCorrect': PropertySchema(
      id: 1,
      name: r'consecutiveCorrect',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'difficulty': PropertySchema(
      id: 3,
      name: r'difficulty',
      type: IsarType.string,
    ),
    r'easeFactor': PropertySchema(
      id: 4,
      name: r'easeFactor',
      type: IsarType.double,
    ),
    r'examples': PropertySchema(
      id: 5,
      name: r'examples',
      type: IsarType.stringList,
    ),
    r'interval': PropertySchema(
      id: 6,
      name: r'interval',
      type: IsarType.long,
    ),
    r'isDifficult': PropertySchema(
      id: 7,
      name: r'isDifficult',
      type: IsarType.bool,
    ),
    r'lastReviewedAt': PropertySchema(
      id: 8,
      name: r'lastReviewedAt',
      type: IsarType.dateTime,
    ),
    r'meaning': PropertySchema(
      id: 9,
      name: r'meaning',
      type: IsarType.string,
    ),
    r'nextReviewAt': PropertySchema(
      id: 10,
      name: r'nextReviewAt',
      type: IsarType.dateTime,
    ),
    r'pastParticiple': PropertySchema(
      id: 11,
      name: r'pastParticiple',
      type: IsarType.string,
    ),
    r'pastSimple': PropertySchema(
      id: 12,
      name: r'pastSimple',
      type: IsarType.string,
    ),
    r'patternGroup': PropertySchema(
      id: 13,
      name: r'patternGroup',
      type: IsarType.string,
    ),
    r'repetitions': PropertySchema(
      id: 14,
      name: r'repetitions',
      type: IsarType.long,
    ),
    r'reviewCount': PropertySchema(
      id: 15,
      name: r'reviewCount',
      type: IsarType.long,
    ),
    r'reviewScore': PropertySchema(
      id: 16,
      name: r'reviewScore',
      type: IsarType.long,
    ),
    r'successCount': PropertySchema(
      id: 17,
      name: r'successCount',
      type: IsarType.long,
    ),
    r'successRate': PropertySchema(
      id: 18,
      name: r'successRate',
      type: IsarType.double,
    ),
    r'uuid': PropertySchema(
      id: 19,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _verbEstimateSize,
  serialize: _verbSerialize,
  deserialize: _verbDeserialize,
  deserializeProp: _verbDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _verbGetId,
  getLinks: _verbGetLinks,
  attach: _verbAttach,
  version: '3.1.0+1',
);

int _verbEstimateSize(
  Verb object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.baseForm.length * 3;
  bytesCount += 3 + object.difficulty.length * 3;
  bytesCount += 3 + object.examples.length * 3;
  {
    for (var i = 0; i < object.examples.length; i++) {
      final value = object.examples[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.meaning;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.pastParticiple.length * 3;
  bytesCount += 3 + object.pastSimple.length * 3;
  {
    final value = object.patternGroup;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _verbSerialize(
  Verb object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.baseForm);
  writer.writeLong(offsets[1], object.consecutiveCorrect);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.difficulty);
  writer.writeDouble(offsets[4], object.easeFactor);
  writer.writeStringList(offsets[5], object.examples);
  writer.writeLong(offsets[6], object.interval);
  writer.writeBool(offsets[7], object.isDifficult);
  writer.writeDateTime(offsets[8], object.lastReviewedAt);
  writer.writeString(offsets[9], object.meaning);
  writer.writeDateTime(offsets[10], object.nextReviewAt);
  writer.writeString(offsets[11], object.pastParticiple);
  writer.writeString(offsets[12], object.pastSimple);
  writer.writeString(offsets[13], object.patternGroup);
  writer.writeLong(offsets[14], object.repetitions);
  writer.writeLong(offsets[15], object.reviewCount);
  writer.writeLong(offsets[16], object.reviewScore);
  writer.writeLong(offsets[17], object.successCount);
  writer.writeDouble(offsets[18], object.successRate);
  writer.writeString(offsets[19], object.uuid);
}

Verb _verbDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Verb();
  object.baseForm = reader.readString(offsets[0]);
  object.consecutiveCorrect = reader.readLong(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.difficulty = reader.readString(offsets[3]);
  object.easeFactor = reader.readDouble(offsets[4]);
  object.examples = reader.readStringList(offsets[5]) ?? [];
  object.id = id;
  object.interval = reader.readLong(offsets[6]);
  object.lastReviewedAt = reader.readDateTimeOrNull(offsets[8]);
  object.meaning = reader.readStringOrNull(offsets[9]);
  object.nextReviewAt = reader.readDateTimeOrNull(offsets[10]);
  object.pastParticiple = reader.readString(offsets[11]);
  object.pastSimple = reader.readString(offsets[12]);
  object.patternGroup = reader.readStringOrNull(offsets[13]);
  object.repetitions = reader.readLong(offsets[14]);
  object.reviewCount = reader.readLong(offsets[15]);
  object.reviewScore = reader.readLong(offsets[16]);
  object.successCount = reader.readLong(offsets[17]);
  object.uuid = reader.readString(offsets[19]);
  return object;
}

P _verbDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readDouble(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _verbGetId(Verb object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _verbGetLinks(Verb object) {
  return [];
}

void _verbAttach(IsarCollection<dynamic> col, Id id, Verb object) {
  object.id = id;
}

extension VerbQueryWhereSort on QueryBuilder<Verb, Verb, QWhere> {
  QueryBuilder<Verb, Verb, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VerbQueryWhere on QueryBuilder<Verb, Verb, QWhereClause> {
  QueryBuilder<Verb, Verb, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Verb, Verb, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterWhereClause> idBetween(
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

  QueryBuilder<Verb, Verb, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterWhereClause> uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension VerbQueryFilter on QueryBuilder<Verb, Verb, QFilterCondition> {
  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'baseForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'baseForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'baseForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'baseForm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'baseForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'baseForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'baseForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'baseForm',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'baseForm',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> baseFormIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'baseForm',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> consecutiveCorrectEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consecutiveCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> consecutiveCorrectGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consecutiveCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> consecutiveCorrectLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consecutiveCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> consecutiveCorrectBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consecutiveCorrect',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'difficulty',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'difficulty',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'difficulty',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> difficultyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'difficulty',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> easeFactorEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'easeFactor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> easeFactorGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'easeFactor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> easeFactorLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'easeFactor',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> easeFactorBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'easeFactor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examples',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'examples',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'examples',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'examples',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'examples',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'examples',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'examples',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'examples',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examples',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'examples',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examples',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examples',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examples',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examples',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examples',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> examplesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'examples',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Verb, Verb, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Verb, Verb, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Verb, Verb, QAfterFilterCondition> intervalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> intervalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> intervalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interval',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> intervalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interval',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> isDifficultEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDifficult',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> lastReviewedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastReviewedAt',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> lastReviewedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastReviewedAt',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> lastReviewedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReviewedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> lastReviewedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReviewedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> lastReviewedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReviewedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> lastReviewedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReviewedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'meaning',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'meaning',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meaning',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'meaning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'meaning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meaning',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> meaningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'meaning',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> nextReviewAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextReviewAt',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> nextReviewAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextReviewAt',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> nextReviewAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextReviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> nextReviewAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextReviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> nextReviewAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextReviewAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> nextReviewAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextReviewAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pastParticiple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pastParticiple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pastParticiple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pastParticiple',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pastParticiple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pastParticiple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pastParticiple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pastParticiple',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pastParticiple',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastParticipleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pastParticiple',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pastSimple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pastSimple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pastSimple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pastSimple',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pastSimple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pastSimple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pastSimple',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pastSimple',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pastSimple',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> pastSimpleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pastSimple',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'patternGroup',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'patternGroup',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patternGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'patternGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'patternGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'patternGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'patternGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'patternGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'patternGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'patternGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'patternGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> patternGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'patternGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> repetitionsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repetitions',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> repetitionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repetitions',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> repetitionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repetitions',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> repetitionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repetitions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewScoreEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewScore',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> reviewScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'successCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'successCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'successCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'successCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successRateEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'successRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successRateGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'successRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successRateLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'successRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> successRateBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'successRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<Verb, Verb, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension VerbQueryObject on QueryBuilder<Verb, Verb, QFilterCondition> {}

extension VerbQueryLinks on QueryBuilder<Verb, Verb, QFilterCondition> {}

extension VerbQuerySortBy on QueryBuilder<Verb, Verb, QSortBy> {
  QueryBuilder<Verb, Verb, QAfterSortBy> sortByBaseForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseForm', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByBaseFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseForm', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByConsecutiveCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveCorrect', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByConsecutiveCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveCorrect', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByEaseFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByEaseFactorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByIsDifficult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDifficult', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByIsDifficultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDifficult', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByLastReviewedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByLastReviewedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByNextReviewAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewAt', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByNextReviewAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewAt', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByPastParticiple() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastParticiple', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByPastParticipleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastParticiple', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByPastSimple() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastSimple', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByPastSimpleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastSimple', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByPatternGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patternGroup', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByPatternGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patternGroup', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByRepetitions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByRepetitionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByReviewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByReviewCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByReviewScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewScore', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByReviewScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewScore', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortBySuccessCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successCount', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortBySuccessCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successCount', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortBySuccessRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successRate', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortBySuccessRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successRate', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension VerbQuerySortThenBy on QueryBuilder<Verb, Verb, QSortThenBy> {
  QueryBuilder<Verb, Verb, QAfterSortBy> thenByBaseForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseForm', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByBaseFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseForm', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByConsecutiveCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveCorrect', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByConsecutiveCorrectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consecutiveCorrect', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByDifficulty() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByDifficultyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficulty', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByEaseFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByEaseFactorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'easeFactor', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByIntervalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interval', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByIsDifficult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDifficult', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByIsDifficultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDifficult', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByLastReviewedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByLastReviewedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReviewedAt', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByMeaning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByMeaningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meaning', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByNextReviewAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewAt', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByNextReviewAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextReviewAt', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByPastParticiple() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastParticiple', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByPastParticipleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastParticiple', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByPastSimple() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastSimple', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByPastSimpleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pastSimple', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByPatternGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patternGroup', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByPatternGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'patternGroup', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByRepetitions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByRepetitionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitions', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByReviewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByReviewCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewCount', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByReviewScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewScore', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByReviewScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewScore', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenBySuccessCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successCount', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenBySuccessCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successCount', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenBySuccessRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successRate', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenBySuccessRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'successRate', Sort.desc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<Verb, Verb, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension VerbQueryWhereDistinct on QueryBuilder<Verb, Verb, QDistinct> {
  QueryBuilder<Verb, Verb, QDistinct> distinctByBaseForm(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'baseForm', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByConsecutiveCorrect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consecutiveCorrect');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByDifficulty(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficulty', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByEaseFactor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'easeFactor');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByExamples() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'examples');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByInterval() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interval');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByIsDifficult() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDifficult');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByLastReviewedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReviewedAt');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByMeaning(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meaning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByNextReviewAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextReviewAt');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByPastParticiple(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pastParticiple',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByPastSimple(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pastSimple', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByPatternGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'patternGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByRepetitions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repetitions');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByReviewCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewCount');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByReviewScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewScore');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctBySuccessCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'successCount');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctBySuccessRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'successRate');
    });
  }

  QueryBuilder<Verb, Verb, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension VerbQueryProperty on QueryBuilder<Verb, Verb, QQueryProperty> {
  QueryBuilder<Verb, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Verb, String, QQueryOperations> baseFormProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baseForm');
    });
  }

  QueryBuilder<Verb, int, QQueryOperations> consecutiveCorrectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consecutiveCorrect');
    });
  }

  QueryBuilder<Verb, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Verb, String, QQueryOperations> difficultyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficulty');
    });
  }

  QueryBuilder<Verb, double, QQueryOperations> easeFactorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'easeFactor');
    });
  }

  QueryBuilder<Verb, List<String>, QQueryOperations> examplesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'examples');
    });
  }

  QueryBuilder<Verb, int, QQueryOperations> intervalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interval');
    });
  }

  QueryBuilder<Verb, bool, QQueryOperations> isDifficultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDifficult');
    });
  }

  QueryBuilder<Verb, DateTime?, QQueryOperations> lastReviewedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReviewedAt');
    });
  }

  QueryBuilder<Verb, String?, QQueryOperations> meaningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meaning');
    });
  }

  QueryBuilder<Verb, DateTime?, QQueryOperations> nextReviewAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextReviewAt');
    });
  }

  QueryBuilder<Verb, String, QQueryOperations> pastParticipleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pastParticiple');
    });
  }

  QueryBuilder<Verb, String, QQueryOperations> pastSimpleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pastSimple');
    });
  }

  QueryBuilder<Verb, String?, QQueryOperations> patternGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'patternGroup');
    });
  }

  QueryBuilder<Verb, int, QQueryOperations> repetitionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repetitions');
    });
  }

  QueryBuilder<Verb, int, QQueryOperations> reviewCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewCount');
    });
  }

  QueryBuilder<Verb, int, QQueryOperations> reviewScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewScore');
    });
  }

  QueryBuilder<Verb, int, QQueryOperations> successCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'successCount');
    });
  }

  QueryBuilder<Verb, double, QQueryOperations> successRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'successRate');
    });
  }

  QueryBuilder<Verb, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
