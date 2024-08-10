class Endpoints {
  Endpoints._();
  static const imageUrl = 'http://83.136.219.131:8000';
  static const login = 'users/login';
  static const signUp = 'users/register';
  static const otpVerify = 'users/verfiyOtp';
  static const socialLogin = 'users/socialLogin';
  static const userUpdate = 'users/update-profile';
  static const uploadImage = 'users/upload';
  static const propertyCrud = 'users/add_edit_del_property';
  static const propTypeList = 'users/propTypeList';
  static const propAssetList = 'users/amenities_list_details';
  static const addTenant = 'users/add_edit_tenant';
  static const rentFrquencyList = 'users/rentFrquencyList';
  static const getPropList = 'users/get_list_details_prop';
  static const getTenantList = 'users/get_tenant_list_details';
  static const addExpense = 'users/add_edit_expense';
  static const getExpenseList = 'users/get_expanse_list_details';
  static const getRoomAndBed = 'users/roomANDbeds';
  static const expenseGraph = 'users/expanse_graph';
}
