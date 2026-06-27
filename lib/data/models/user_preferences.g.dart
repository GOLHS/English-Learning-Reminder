// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserPreferencesCollection on Isar {
  IsarCollection<UserPreferences> get userPreferences => this.collection();
}

const UserPreferencesSchema = CollectionSchema(
  name: r'UserPreferences',
  id: -7545901164102504045,
  properties: {
    r'aiApiKey': PropertySchema(
      id: 0,
      name: r'aiApiKey',
      type: IsarType.string,
    ),
    r'aiModel': PropertySchema(
      id: 1,
      name: r'aiModel',
      type: IsarType.string,
    ),
    r'aiProvider': PropertySchema(
      id: 2,
      name: r'aiProvider',
      type: IsarType.string,
    ),
    r'autoPlayPronunciation': PropertySchema(
      id: 3,
      name: r'autoPlayPronunciation',
      type: IsarType.bool,
    ),
    r'defaultVerbReviewMode': PropertySchema(
      id: 4,
      name: r'defaultVerbReviewMode',
      type: IsarType.string,
    ),
    r'maxDailyReviews': PropertySchema(
      id: 5,
      name: r'maxDailyReviews',
      type: IsarType.long,
    ),
    r'notificationDays': PropertySchema(
      id: 6,
      name: r'notificationDays',
      type: IsarType.stringList,
    ),
    r'notificationEnabled': PropertySchema(
      id: 7,
      name: r'notificationEnabled',
      type: IsarType.bool,
    ),
    r'notificationHour': PropertySchema(
      id: 8,
      name: r'notificationHour',
      type: IsarType.long,
    ),
    r'notificationMinute': PropertySchema(
      id: 9,
      name: r'notificationMinute',
      type: IsarType.long,
    ),
    r'onboardingCompleted': PropertySchema(
      id: 10,
      name: r'onboardingCompleted',
      type: IsarType.bool,
    ),
    r'quietHoursEnd': PropertySchema(
      id: 11,
      name: r'quietHoursEnd',
      type: IsarType.long,
    ),
    r'quietHoursStart': PropertySchema(
      id: 12,
      name: r'quietHoursStart',
      type: IsarType.long,
    ),
    r'reviewIntensity': PropertySchema(
      id: 13,
      name: r'reviewIntensity',
      type: IsarType.string,
    ),
    r'reviewPeriod': PropertySchema(
      id: 14,
      name: r'reviewPeriod',
      type: IsarType.string,
    ),
    r'reviewsPerWord': PropertySchema(
      id: 15,
      name: r'reviewsPerWord',
      type: IsarType.long,
    ),
    r'showExamplesDuringRecall': PropertySchema(
      id: 16,
      name: r'showExamplesDuringRecall',
      type: IsarType.bool,
    ),
    r'themeMode': PropertySchema(
      id: 17,
      name: r'themeMode',
      type: IsarType.string,
    ),
    r'typingMode': PropertySchema(
      id: 18,
      name: r'typingMode',
      type: IsarType.bool,
    )
  },
  estimateSize: _userPreferencesEstimateSize,
  serialize: _userPreferencesSerialize,
  deserialize: _userPreferencesDeserialize,
  deserializeProp: _userPreferencesDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userPreferencesGetId,
  getLinks: _userPreferencesGetLinks,
  attach: _userPreferencesAttach,
  version: '3.1.0+1',
);

int _userPreferencesEstimateSize(
  UserPreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aiApiKey.length * 3;
  bytesCount += 3 + object.aiModel.length * 3;
  bytesCount += 3 + object.aiProvider.length * 3;
  bytesCount += 3 + object.defaultVerbReviewMode.length * 3;
  bytesCount += 3 + object.notificationDays.length * 3;
  {
    for (var i = 0; i < object.notificationDays.length; i++) {
      final value = object.notificationDays[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.reviewIntensity.length * 3;
  bytesCount += 3 + object.reviewPeriod.length * 3;
  bytesCount += 3 + object.themeMode.length * 3;
  return bytesCount;
}

void _userPreferencesSerialize(
  UserPreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aiApiKey);
  writer.writeString(offsets[1], object.aiModel);
  writer.writeString(offsets[2], object.aiProvider);
  writer.writeBool(offsets[3], object.autoPlayPronunciation);
  writer.writeString(offsets[4], object.defaultVerbReviewMode);
  writer.writeLong(offsets[5], object.maxDailyReviews);
  writer.writeStringList(offsets[6], object.notificationDays);
  writer.writeBool(offsets[7], object.notificationEnabled);
  writer.writeLong(offsets[8], object.notificationHour);
  writer.writeLong(offsets[9], object.notificationMinute);
  writer.writeBool(offsets[10], object.onboardingCompleted);
  writer.writeLong(offsets[11], object.quietHoursEnd);
  writer.writeLong(offsets[12], object.quietHoursStart);
  writer.writeString(offsets[13], object.reviewIntensity);
  writer.writeString(offsets[14], object.reviewPeriod);
  writer.writeLong(offsets[15], object.reviewsPerWord);
  writer.writeBool(offsets[16], object.showExamplesDuringRecall);
  writer.writeString(offsets[17], object.themeMode);
  writer.writeBool(offsets[18], object.typingMode);
}

UserPreferences _userPreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserPreferences();
  object.aiApiKey = reader.readString(offsets[0]);
  object.aiModel = reader.readString(offsets[1]);
  object.aiProvider = reader.readString(offsets[2]);
  object.autoPlayPronunciation = reader.readBool(offsets[3]);
  object.defaultVerbReviewMode = reader.readString(offsets[4]);
  object.id = id;
  object.maxDailyReviews = reader.readLong(offsets[5]);
  object.notificationDays = reader.readStringList(offsets[6]) ?? [];
  object.notificationEnabled = reader.readBool(offsets[7]);
  object.notificationHour = reader.readLong(offsets[8]);
  object.notificationMinute = reader.readLong(offsets[9]);
  object.onboardingCompleted = reader.readBool(offsets[10]);
  object.quietHoursEnd = reader.readLong(offsets[11]);
  object.quietHoursStart = reader.readLong(offsets[12]);
  object.reviewIntensity = reader.readString(offsets[13]);
  object.reviewPeriod = reader.readString(offsets[14]);
  object.reviewsPerWord = reader.readLong(offsets[15]);
  object.showExamplesDuringRecall = reader.readBool(offsets[16]);
  object.themeMode = reader.readString(offsets[17]);
  object.typingMode = reader.readBool(offsets[18]);
  return object;
}

P _userPreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readBool(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userPreferencesGetId(UserPreferences object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userPreferencesGetLinks(UserPreferences object) {
  return [];
}

void _userPreferencesAttach(
    IsarCollection<dynamic> col, Id id, UserPreferences object) {
  object.id = id;
}

extension UserPreferencesQueryWhereSort
    on QueryBuilder<UserPreferences, UserPreferences, QWhere> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserPreferencesQueryWhere
    on QueryBuilder<UserPreferences, UserPreferences, QWhereClause> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterWhereClause> idBetween(
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

extension UserPreferencesQueryFilter
    on QueryBuilder<UserPreferences, UserPreferences, QFilterCondition> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiApiKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiApiKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiApiKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiApiKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiApiKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiApiKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiModel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiModel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiModel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiModel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiModelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiModel',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiProvider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aiProvider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aiProvider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aiProvider',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aiProvider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aiProvider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aiProvider',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aiProvider',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aiProvider',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      aiProviderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aiProvider',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      autoPlayPronunciationEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'autoPlayPronunciation',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultVerbReviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultVerbReviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultVerbReviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultVerbReviewMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultVerbReviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultVerbReviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultVerbReviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultVerbReviewMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultVerbReviewMode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      defaultVerbReviewModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultVerbReviewMode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      maxDailyReviewsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxDailyReviews',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      maxDailyReviewsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxDailyReviews',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      maxDailyReviewsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxDailyReviews',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      maxDailyReviewsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxDailyReviews',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notificationDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notificationDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notificationDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notificationDays',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationDays',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notificationDays',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationDays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationDays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationDays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationDays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationDays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'notificationDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationHourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationHourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationHourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationHour',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationHourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationHour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationMinuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationMinuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationMinuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationMinute',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      notificationMinuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationMinute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      onboardingCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'onboardingCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursEndEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quietHoursEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursEndGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quietHoursEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursEndLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quietHoursEnd',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursEndBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quietHoursEnd',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursStartEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quietHoursStart',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursStartGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quietHoursStart',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursStartLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quietHoursStart',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      quietHoursStartBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quietHoursStart',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewIntensity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reviewIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reviewIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reviewIntensity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reviewIntensity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewIntensity',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewIntensityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reviewIntensity',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewPeriod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewPeriod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewPeriod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewPeriod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reviewPeriod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reviewPeriod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reviewPeriod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reviewPeriod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewPeriod',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewPeriodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reviewPeriod',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewsPerWordEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reviewsPerWord',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewsPerWordGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reviewsPerWord',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewsPerWordLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reviewsPerWord',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      reviewsPerWordBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reviewsPerWord',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      showExamplesDuringRecallEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'showExamplesDuringRecall',
        value: value,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'themeMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      themeModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'themeMode',
        value: '',
      ));
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterFilterCondition>
      typingModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typingMode',
        value: value,
      ));
    });
  }
}

extension UserPreferencesQueryObject
    on QueryBuilder<UserPreferences, UserPreferences, QFilterCondition> {}

extension UserPreferencesQueryLinks
    on QueryBuilder<UserPreferences, UserPreferences, QFilterCondition> {}

extension UserPreferencesQuerySortBy
    on QueryBuilder<UserPreferences, UserPreferences, QSortBy> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAiApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiApiKey', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAiApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiApiKey', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> sortByAiModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModel', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAiModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModel', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAiProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiProvider', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAiProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiProvider', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAutoPlayPronunciation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPlayPronunciation', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByAutoPlayPronunciationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPlayPronunciation', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByDefaultVerbReviewMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultVerbReviewMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByDefaultVerbReviewModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultVerbReviewMode', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByMaxDailyReviews() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDailyReviews', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByMaxDailyReviewsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDailyReviews', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByNotificationHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByNotificationHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationHour', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByNotificationMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationMinute', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByNotificationMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationMinute', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByQuietHoursEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByQuietHoursEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByQuietHoursStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByQuietHoursStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByReviewIntensity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewIntensity', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByReviewIntensityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewIntensity', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByReviewPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewPeriod', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByReviewPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewPeriod', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByReviewsPerWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewsPerWord', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByReviewsPerWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewsPerWord', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByShowExamplesDuringRecall() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExamplesDuringRecall', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByShowExamplesDuringRecallDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExamplesDuringRecall', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByTypingMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typingMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      sortByTypingModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typingMode', Sort.desc);
    });
  }
}

extension UserPreferencesQuerySortThenBy
    on QueryBuilder<UserPreferences, UserPreferences, QSortThenBy> {
  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAiApiKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiApiKey', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAiApiKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiApiKey', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByAiModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModel', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAiModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiModel', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAiProvider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiProvider', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAiProviderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aiProvider', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAutoPlayPronunciation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPlayPronunciation', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByAutoPlayPronunciationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'autoPlayPronunciation', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByDefaultVerbReviewMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultVerbReviewMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByDefaultVerbReviewModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultVerbReviewMode', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByMaxDailyReviews() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDailyReviews', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByMaxDailyReviewsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxDailyReviews', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByNotificationHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationHour', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByNotificationHourDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationHour', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByNotificationMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationMinute', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByNotificationMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationMinute', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByOnboardingCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'onboardingCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByQuietHoursEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByQuietHoursEndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursEnd', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByQuietHoursStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByQuietHoursStartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quietHoursStart', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByReviewIntensity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewIntensity', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByReviewIntensityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewIntensity', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByReviewPeriod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewPeriod', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByReviewPeriodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewPeriod', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByReviewsPerWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewsPerWord', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByReviewsPerWordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reviewsPerWord', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByShowExamplesDuringRecall() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExamplesDuringRecall', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByShowExamplesDuringRecallDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'showExamplesDuringRecall', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByTypingMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typingMode', Sort.asc);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QAfterSortBy>
      thenByTypingModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typingMode', Sort.desc);
    });
  }
}

extension UserPreferencesQueryWhereDistinct
    on QueryBuilder<UserPreferences, UserPreferences, QDistinct> {
  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByAiApiKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiApiKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByAiModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiModel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByAiProvider({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aiProvider', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByAutoPlayPronunciation() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'autoPlayPronunciation');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByDefaultVerbReviewMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultVerbReviewMode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByMaxDailyReviews() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxDailyReviews');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByNotificationDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationDays');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationEnabled');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByNotificationHour() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationHour');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByNotificationMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationMinute');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByOnboardingCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByQuietHoursEnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursEnd');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByQuietHoursStart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quietHoursStart');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByReviewIntensity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewIntensity',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByReviewPeriod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewPeriod', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByReviewsPerWord() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reviewsPerWord');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByShowExamplesDuringRecall() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'showExamplesDuringRecall');
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct> distinctByThemeMode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserPreferences, UserPreferences, QDistinct>
      distinctByTypingMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typingMode');
    });
  }
}

extension UserPreferencesQueryProperty
    on QueryBuilder<UserPreferences, UserPreferences, QQueryProperty> {
  QueryBuilder<UserPreferences, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations> aiApiKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiApiKey');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations> aiModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiModel');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations> aiProviderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aiProvider');
    });
  }

  QueryBuilder<UserPreferences, bool, QQueryOperations>
      autoPlayPronunciationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'autoPlayPronunciation');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations>
      defaultVerbReviewModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultVerbReviewMode');
    });
  }

  QueryBuilder<UserPreferences, int, QQueryOperations>
      maxDailyReviewsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxDailyReviews');
    });
  }

  QueryBuilder<UserPreferences, List<String>, QQueryOperations>
      notificationDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationDays');
    });
  }

  QueryBuilder<UserPreferences, bool, QQueryOperations>
      notificationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationEnabled');
    });
  }

  QueryBuilder<UserPreferences, int, QQueryOperations>
      notificationHourProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationHour');
    });
  }

  QueryBuilder<UserPreferences, int, QQueryOperations>
      notificationMinuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationMinute');
    });
  }

  QueryBuilder<UserPreferences, bool, QQueryOperations>
      onboardingCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'onboardingCompleted');
    });
  }

  QueryBuilder<UserPreferences, int, QQueryOperations> quietHoursEndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursEnd');
    });
  }

  QueryBuilder<UserPreferences, int, QQueryOperations>
      quietHoursStartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quietHoursStart');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations>
      reviewIntensityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewIntensity');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations>
      reviewPeriodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewPeriod');
    });
  }

  QueryBuilder<UserPreferences, int, QQueryOperations>
      reviewsPerWordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reviewsPerWord');
    });
  }

  QueryBuilder<UserPreferences, bool, QQueryOperations>
      showExamplesDuringRecallProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'showExamplesDuringRecall');
    });
  }

  QueryBuilder<UserPreferences, String, QQueryOperations> themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }

  QueryBuilder<UserPreferences, bool, QQueryOperations> typingModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typingMode');
    });
  }
}
