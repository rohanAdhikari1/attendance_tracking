// import 'package:survey/data/local/db_helper.dart';
// import 'package:survey/models/data.dart';
// import 'package:sqflite/sqflite.dart';
//
// class RecordRepository{
//   get _db => DBHelper.getInstance;
//
//   Future<int> insertRecordPart1(String name,String address1,String type,String address2,String ward,String gender,String phone,String occupation,int totalMale,int totalFemale,int countMale,int countFemale) async{
//     var db = await _db.getDB();
//     int rowEffected1 = await db.insert(DBHelper.TABLE_HOUSE_REPRESENTATIVE,
//         {
//           'name':name,
//           'ward_no':ward,
//           'gender':gender,
//           'contact_no':phone,
//           'occupation':occupation,
//           'address_1':address1,
//           'address_2':address2,
//           'family_members_male_count':totalMale,
//           'family_members_female_count':totalFemale,
//           'family_members_migration_male_count':countMale,
//           'family_members_migration_female_count ':countFemale,
//           'created_at':DateTime.now().toIso8601String(),
//           'updated_at' : DateTime.now().toIso8601String(),
//         },conflictAlgorithm: ConflictAlgorithm.replace);
//     int rowEffected = await db.insert(DBHelper.TABLE_RECORD, {
//       'house_representative_id':rowEffected1,
//       'type':type,
//       'is_completed': 0,
//       'created_at':DateTime.now().toIso8601String(),
//       'updated_at' : DateTime.now().toIso8601String(),
//     },conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//     return rowEffected;
//   }
//
//    Future<void> updateRecordGroupAPart1(int recordId,String name,int age,String country,String visitTime,String foreignOccupation,String gender, String caste,String maritalStatus,String contactTimes) async{
//    var db = await _db.getDB();
//    await db.update(DBHelper.TABLE_RECORD,
//        {
//          'name':name,
//          'gender':gender,
//          'age':age,
//          'caste':caste,
//          'marital_status':maritalStatus,
//          'migrated_country':country,
//          'migrated_times':visitTime,
//          'foreign_occupation':foreignOccupation,
//          'home_contact_times':contactTimes,
//          'updated_at': DateTime.now().toIso8601String(),
//        },
//        where: 'id = ?',
//        whereArgs: [recordId]);
//  }
//
//   Future<void> updateRecordGroupAPart2(int recordId,int isSkilled,String skillName,int havePermission,String permissionMethod,int haveDocumentInHome,String document) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'is_skilled':isSkilled,
//           'skilled_occupation': skillName,
//           'have_communication_permission':havePermission,
//           'communication_permission_method':permissionMethod,
//           'have_document_in_home':haveDocumentInHome,
//           'document_type':document,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupAPart3(int recordId,String travelMethod,String travelRoad,String travelFee,String paidSource,String loanSource,String interestOnLoan,int loanPaid,String loanPaidDuration,int abroadProblem,String problemType) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'travel_method': travelMethod,
//           'travel_road':travelRoad,
//           'travel_fee':travelFee,
//           'expense_source_abroad':paidSource,
//           'loan_taken_from':loanSource,
//           'interest_rate_on_loan':interestOnLoan,
//           'is_loan_fully_repaid':loanPaid,
//           'loan_repayment_duration':loanPaidDuration,
//           'faced_problems_abroad':abroadProblem,
//           'problem_type':problemType,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupBPart4(int recordId,int employeeOnBusiness,String businessHelpFromGovernment,String expectedHelpFromGovernment,String difficultiesToStartBusiness) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'employees_on_current_business': employeeOnBusiness,
//           'business_help_government': businessHelpFromGovernment,
//           'want_help_type_from_business': expectedHelpFromGovernment,
//           'difficulties_to_start_business':difficultiesToStartBusiness,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupAPart4(int recordId,String covidHealthIssue,String foreignEmploymentFamilyIssue,String covidProblem) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'have_covid_related_problem':covidProblem.isNotEmpty,
//           'covid_problem_type':covidProblem,
//           'covid_health_issue':covidHealthIssue.isNotEmpty,
//           'covid_health_issue_type': covidHealthIssue,
//           'home_problem':foreignEmploymentFamilyIssue.isNotEmpty,
//           'home_problem_type':foreignEmploymentFamilyIssue,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupAPart5(int recordId,int isRemarried,String reMarriedGender,int isElderAloneOnHome,int isChildrenOutForStudy,String childrenStudyLocation,String foreignMonthlyIncome,String salaryChangedDueTOCovid,String remittanceMethod,int remittanceCount,String remittanceAmount) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'is_remarried':isRemarried,
//           'remarried_gender':reMarriedGender,
//           'is_elder_only_home':isElderAloneOnHome,
//           'is_children_out_for_study':isChildrenOutForStudy,
//           'children_study_location':childrenStudyLocation,
//           'total_foreign_income':foreignMonthlyIncome,
//           'is_salary_changed_due_to_covid':salaryChangedDueTOCovid.isNotEmpty,
//           'salary_change':salaryChangedDueTOCovid,
//           'remittance_method':remittanceMethod,
//           'previous_year_remittance_count':remittanceCount,
//           'previous_year_remittance_amount':remittanceAmount,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupAPart6(int recordId,String remittanceSavedSource,String planAfterReturn,int landFromRemittance,String landFromRemittanceLocation,String migrationPlanLocation,String remittanceSpendSource) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'is_remittance_saved': remittanceSavedSource.isNotEmpty,
//           'remittance_saving_method': remittanceSavedSource,
//           'is_land_purchased':landFromRemittance,
//           'plan_after_return':planAfterReturn,
//           'land_purchased_location':landFromRemittanceLocation,
//           'have_plan_to_migrate':migrationPlanLocation.isNotEmpty,
//           'migration_plan_location':migrationPlanLocation,
//           'remittance_spend_source':remittanceSpendSource,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupBPart1(int recordId,String name,String gender,int age,String maritalStatus,String caste,int totalFamilyReturnMale, int totalFamilyReturnFeMale,String homeReturnAfter,String homeReturnReason,String country,int migratedTimes) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'name':name,
//           'gender':gender,
//           'age':age,
//           'caste':caste,
//           'marital_status':maritalStatus,
//           'total_family_returned':totalFamilyReturnMale+totalFamilyReturnFeMale,
//           'total_family_returned_male':totalFamilyReturnMale,
//           'total_family_returned_female':totalFamilyReturnFeMale,
//           'home_returned_after':homeReturnAfter,
//           'home_return_reason':homeReturnReason,
//           'migrated_country':country,
//           'migrated_times':migratedTimes,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupBPart2(int recordId,int wantTogoAgain,String occupationNow,String employedAs, String skillBeforeMigration, String skillOccupation,int knowSkillTest,int haveDoneSkillTest,int wantSkillTest) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'want_to_go_again':wantTogoAgain,
//           'occupation_now':occupationNow,
//           'is_employed':employedAs.isNotEmpty,
//           'employed_as':employedAs,
//           'skill_before_migration':skillBeforeMigration,
//           'is_skilled':skillBeforeMigration.isNotEmpty,
//           'skilled_occupation':skillOccupation,
//           'know_skill_test':knowSkillTest,
//           'have_done_skill_test':haveDoneSkillTest,
//           'want_to_skill_test':wantSkillTest,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateRecordGroupBPart3(int recordId,String savedForeignIncome,int planToBusiness,int doingBusiness,String remittanceSpendSource,String businessPlan,String currentBusiness) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'saved_foreign_income':savedForeignIncome,
//           'plan_to_business':planToBusiness,
//           'doing_business':doingBusiness,
//           'remittance_spend_source':remittanceSpendSource,
//           'business_plan':businessPlan,
//           'current_business':currentBusiness,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<void> updateLocation(int recordId,String latitude,String longitude) async{
//     var db = await _db.getDB();
//     await db.update(DBHelper.TABLE_RECORD,
//         {
//           'is_completed': 1,
//           'longitude':longitude,
//           'latitude':latitude,
//           'updated_at': DateTime.now().toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [recordId]);
//   }
//
//   Future<Map<String, int>> getCounts() async {
//     var db = await _db.getDB();
//     var draftCountResult = await db.rawQuery('SELECT COUNT(*) FROM ${DBHelper.TABLE_RECORD} WHERE is_completed = 0');
//     var completedCountResult = await db.rawQuery('SELECT COUNT(*) FROM ${DBHelper.TABLE_RECORD} WHERE is_completed = 1');
//     int draftCount = Sqflite.firstIntValue(draftCountResult) ?? 0;
//     int completedCount = Sqflite.firstIntValue(completedCountResult) ?? 0;
//     return {
//       'drafts': draftCount,
//       'completed': completedCount,
//     };
//   }
//
//
//   Future<List<DataModel>> getCompletedRecords() async{
//    var db = await _db.getDB();
//    var result = await db.rawQuery('''SELECT id,name,contact_no,migrated_country,caste,type FROM ${DBHelper.TABLE_RECORD} WHERE is_completed = 1 ORDER BY updated_at desc''');
//    List<Map<String, dynamic>> recordMap = List<Map<String, dynamic>>.from(result);
//    List<DataModel> records = recordMap.map((Map<String, dynamic> map) => DataModel.fromMap(map)).toList();
//    return records;
//  }
//
//   Future<List<DataModel>> getDraftRecords() async{
//     var db = await _db.getDB();
//     var result = await db.rawQuery('''SELECT id,name,contact_no,migrated_country,caste,type FROM ${DBHelper.TABLE_RECORD} WHERE is_completed = 0 ORDER BY updated_at desc''');
//     List<Map<String, dynamic>> recordMap = List<Map<String, dynamic>>.from(result);
//     List<DataModel> records = recordMap.map((Map<String, dynamic> map) => DataModel.fromMap(map)).toList();
//     return records;
//   }
//
//   Future<bool> deleteRecord(int recordId) async{
//     var db = await _db.getDB();
//     try{
//       await db.delete(
//         DBHelper.TABLE_RECORD,
//         where: 'id = ?',
//         whereArgs: [recordId],
//       );
//       var result = await db.rawQuery('''SELECT house_representative_id FROM ${DBHelper.TABLE_RECORD} WHERE id = ?''', [recordId]);
//       if (result.isNotEmpty) {
//         var representativeId = result[0]['house_representative_id'];
//         await db.delete(
//           DBHelper.TABLE_HOUSE_REPRESENTATIVE,
//           where: 'id = ?',
//           whereArgs: [representativeId],
//         );
//       }
//       return true;
//     }catch(_){
//       return false;
//     }
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupAPart1(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,name,gender,age,marital_status,migrated_country,caste,foreign_occupation,home_contact_times,migrated_times FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupAPart2(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,is_skilled,skilled_occupation,have_communication_permission,communication_permission_method,have_document_in_home,document_type FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupAPart3(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,travel_method,travel_road,travel_fee,expense_source_abroad,loan_taken_from,interest_rate_on_loan,is_loan_fully_repaid,loan_repayment_duration,faced_problems_abroad,problem_type FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupAPart4(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,covid_health_issue,covid_health_issue_type,home_problem,home_problem_type,covid_problem_type FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupAPart5(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,is_remarried,remarried_gender,is_elder_only_home,is_children_out_for_study,children_study_location,total_foreign_income,salary_change,remittance_method,previous_year_remittance_count,previous_year_remittance_amount FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupAPart6(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,is_remittance_saved,remittance_saving_method,is_land_purchased,land_purchased_location,have_plan_to_migrate,migration_plan_location,plan_after_return,remittance_spend_source FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupBPart1(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,name,gender,age,caste,marital_status,total_family_returned,total_family_returned_male,total_family_returned_female,
//     home_returned_after,home_return_reason,migrated_country,migrated_times FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupBPart2(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,want_to_go_again,occupation_now,is_employed,employed_as,skill_before_migration,is_skilled,skilled_occupation,know_skill_test,have_done_skill_test,want_to_skill_test FROM
//     ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupBPart3(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,saved_foreign_income,plan_to_business,doing_business,remittance_spend_source,business_plan,current_business FROM ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecordGroupBPart4(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''
//     SELECT id,employees_on_current_business,business_help_government,want_help_type_from_business,difficulties_to_start_business FROM ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveRecord(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''SELECT * FROM ${DBHelper.TABLE_RECORD} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
//
//   Future<Map<String,dynamic>> retrieveHouseRepresentative(int recordId) async{
//     var db = await _db.getDB();
//     var result =  await db.rawQuery('''SELECT * FROM ${DBHelper.TABLE_HOUSE_REPRESENTATIVE} WHERE id = $recordId''');
//     return result.isNotEmpty ? result.first : null;
//   }
// }