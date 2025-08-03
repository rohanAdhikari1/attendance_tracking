// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBHelper{
//   DBHelper._();
//
//   static final DBHelper getInstance = DBHelper._();
//
//   static final String TABLE_HOUSE_REPRESENTATIVE = "house_representatives";
//   static final String TABLE_RECORD = "migrant_workers";
//
//   Database? myDB;
//
//   //open db if  else create
//   Future<Database> getDB() async{
//     myDB ??= await openDB();
//     return myDB!;
//   }
//
//   Future<Database> openDB() async{
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String dbPath = join(appDir.path,"surveyDB.db");
//     String houseRepresentativeTableQuery = "CREATE TABLE $TABLE_HOUSE_REPRESENTATIVE (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,gender TEXT,contact_no TEXT,occupation TEXT,address TEXT,family_members_male_count INTEGER,family_members_female_count INTEGER,family_members_other_count INTEGER,family_migration_count INTEGER, family_members_migration_male_count INTEGER,family_members_migration_female_count INTEGER,family_members_migration_other_count INTEGER,ward_no INTEGER,address_1 TEXT,address_2 TEXT,house_no TEXT,created_at TEXT,updated_at TEXT)";
//     String recordTableQuery = "CREATE TABLE $TABLE_RECORD (" +
//         "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
//         "type TEXT CHECK(type IN ('current', 'return')) NOT NULL, " +
//         "house_representative_id INTEGER NOT NULL, " +
//         "name TEXT, " +
//         "gender TEXT, " +
//         "age INTEGER, " +
//         "contact_no TEXT, " +
//         "caste TEXT, " +
//         "marital_status TEXT, " +
//         "is_completed INTEGER, " +
//         "total_family_returned INTEGER, " +
//         "total_family_returned_male INTEGER, " +
//         "total_family_returned_female INTEGER, " +
//         "total_family_returned_other INTEGER, " +
//         "migrated_country TEXT, " +
//         "migrated_times INTEGER, " +
//         "foreign_occupation TEXT, " +
//         "emergency_contact_number TEXT, " +
//         "have_communication_permission INTEGER, " +
//         "communication_permission_method TEXT, " +
//         "have_document_in_home INTEGER, " +
//         "document_type TEXT, " +
//         "home_contact_times TEXT, " +
//         "is_skilled INTEGER, " +
//         "skilled_occupation TEXT, " +
//         "know_skill_test INTEGER, " +
//         "have_done_skill_test INTEGER, " +
//         "want_to_skill_test INTEGER, " +
//         "skill_before_migration TEXT, " +
//         "travel_method TEXT, " +
//         "travel_road TEXT, " +
//         "travel_fee TEXT, " +
//         "expense_source_abroad TEXT, " +
//         "foreign_income_used_for TEXT, " +
//         "saved_foreign_income TEXT, " +
//         "remittance_method TEXT, " +
//         "is_salary_changed_due_to_covid INTEGER, " +
//         "salary_change TEXT, " +
//         "want_to_go_again INTEGER, " +
//         "occupation_now TEXT, " +
//         "is_employed INTEGER, " +
//         "employed_as TEXT, " +
//         "plan_to_business INTEGER, " +
//         "business_plan TEXT, " +
//         "doing_business INTEGER, " +
//         "current_business TEXT, " +
//         "employees_on_current_business INTEGER, " +
//         "business_help_government TEXT, " +
//         "want_help_type_from_business TEXT, " +
//         "difficulties_to_start_business TEXT, " +
//         "loan_taken_from TEXT, " +
//         "interest_rate_on_loan TEXT, " +
//         "is_loan_fully_repaid INTEGER, " +
//         "loan_repayment_duration TEXT, " +
//         "faced_problems_abroad INTEGER, " +
//         "problem_type TEXT, " +
//         "have_covid_related_problem INTEGER, " +
//         "covid_problem_type TEXT, " +
//         "is_remarried INTEGER, " +
//         "remarried_gender TEXT, " +
//         "is_elder_only_home INTEGER, " +
//         "is_children_out_for_study INTEGER, " +
//         "children_study_location TEXT, " +
//         "total_foreign_income TEXT, " +
//         "covid_health_issue INTEGER, " +
//         "covid_health_issue_type TEXT, " +
//         "home_problem INTEGER, " +
//         "home_problem_type TEXT, " +
//         "home_returned_after TEXT, " +
//         "home_return_reason TEXT, " +
//         "is_remittance_saved INTEGER, " +
//         "remittance_saving_method TEXT, " +
//         "remittance_before_covid TEXT, " +
//         "is_land_purchased INTEGER, " +
//         "previous_year_remittance_count INTEGER, " +
//         "previous_year_remittance_amount TEXT, " +
//         "plan_after_return TEXT, " +
//         "remittance_spend_source TEXT, " +
//         "land_purchased_location TEXT, " +
//         "have_plan_to_migrate INTEGER, " +
//         "migration_plan_location TEXT, " +
//         "is_other_member_also_on_foreign INTEGER, " +
//         "latitude REAL, " +
//         "longitude REAL, " +
//         "created_at TEXT, " +
//         "updated_at TEXT, " +
//         "FOREIGN KEY (house_representative_id) REFERENCES house_representatives(id) ON DELETE CASCADE" +
//         ");";
//
//     return await openDatabase(dbPath,onCreate: (db,version){
//       //create all tables
//       //to enable foreign key support
//       db.execute('PRAGMA foreign_keys = ON;');
//       db.execute(houseRepresentativeTableQuery);
//       db.execute(recordTableQuery);
//     },version: 1);
//   }
//
//   Future<void> delete() async{
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String dbPath = join(appDir.path,"surveyDB.db");
//     await deleteDatabase(dbPath);
//   }
// }