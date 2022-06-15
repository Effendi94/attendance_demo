import 'dart:convert';
// import 'dart:typed_data';

import 'package:attendance/core.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import 'package:http/http.dart' as http;

part 'database_connection.g.dart';

const SqfEntityTable tableUser = SqfEntityTable(
  tableName: 'users',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
  modelName: 'tableUser',
  // SqfEntity will set it to TableName automatically when the modelName (class name) is null
  // declare fields
  fields: [
    SqfEntityField('username', DbType.text, isNotNull: false),
    SqfEntityField('password', DbType.text, isNotNull: false),
  ],
);

const SqfEntityTable tableLocation = SqfEntityTable(
  tableName: 'locations',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
  modelName: 'tableLocation',
  // SqfEntity will set it to TableName automatically when the modelName (class name) is null
  // declare fields
  fields: [
    SqfEntityField('desc', DbType.text, isNotNull: false),
    SqfEntityField('longtitude', DbType.real, isNotNull: false),
    SqfEntityField('latitude', DbType.real, isNotNull: false),
    SqfEntityField('isActive', DbType.bool,
        defaultValue: false, isNotNull: false),
  ],
);

const SqfEntityTable tableAttendance = SqfEntityTable(
  tableName: 'attendances',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
  modelName: 'tableAttendance',
  // SqfEntity will set it to TableName automatically when the modelName (class name) is null
  // declare fields
  fields: [
    SqfEntityField('attendance_type', DbType.text, isNotNull: false),
    SqfEntityField('longitude', DbType.real, isNotNull: false),
    SqfEntityField('latitude', DbType.real, isNotNull: false),
    SqfEntityField('attendance_at', DbType.datetime, isNotNull: false),
    SqfEntityFieldRelationship(
      parentTable: tableUser,
      relationType: RelationType.ONE_TO_MANY,
      deleteRule: DeleteRule.CASCADE,
      isNotNull: true,
    ),
  ],
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: 'AttendanceDatabase',
  databaseName: 'db_attendance.db',
  password: null,
  databaseTables: [
    tableUser,
    tableLocation,
    tableAttendance,
  ],
  dbVersion: 2,
  defaultColumns: [
    SqfEntityField('createdAt', DbType.datetimeUtc,
        defaultValue: 'DateTime.now()'),
    SqfEntityField('updatedAt', DbType.datetimeUtc,
        defaultValue: 'DateTime.now()'),
  ],
);
