import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/shop_layout/cubit/states.dart';
import 'package:todoapp/models/categories_model.dart';
import 'package:todoapp/models/change_password_model.dart';
import 'package:todoapp/models/favorite_model.dart';
import 'package:todoapp/models/favorites_model.dart';
import 'package:todoapp/models/fqa_model.dart';
import 'package:todoapp/models/home_model.dart';
import 'package:todoapp/models/product_model.dart';
import 'package:todoapp/models/shop_search_model.dart';
import 'package:todoapp/models/updateUserModel.dart';
import 'package:todoapp/models/user_data_model.dart';
import 'package:todoapp/modules/shop_app/categories_screen/categories_screen.dart';
import 'package:todoapp/modules/shop_app/favourite_screen/favourite_screen.dart';
import 'package:todoapp/modules/shop_app/products_screen/products_screen.dart';
import 'package:todoapp/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:todoapp/shared/componants/componants.dart';
import 'package:todoapp/shared/componants/constants.dart';
import 'package:todoapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  // Bottom Nav Bar
  int currentIndex = 0;

  List<Widget> shopScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
    if(index == 2) getFavorites();
    if(index == 3) getUserData();
  }

  // Check Connection
  Future<ConnectivityResult> checkConnection() async {
    return await (Connectivity().checkConnectivity());
  }

  // Get Home Data

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  Future<void> getStartData() async {
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        homeModel = null;
        emit(ShopLoadingHomeDataState());
        await DioHelper.getData(url: 'home', token: token).then((value) {
          homeModel = HomeModel.fromJson(value.data);
          for (var element in homeModel!.data!.products!) {
            favorites.addAll({
              element.id!: element.inFavorites!,
            });
          }
          emit(ShopSuccessHomeDataState());
        }).catchError((error) {
          print(error.toString());
          emit(ShopConnectionErrorStartState());
        });
      } else {
        emit(ShopConnectionErrorStartState());
      }
    });
  }

  Future<void> getHomeData() async {
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        homeModel = null;
        emit(ShopLoadingHomeDataState());
        await DioHelper.getData(url: 'home', token: token).then((value) {
          homeModel = HomeModel.fromJson(value.data);
          for (var element in homeModel!.data!.products!) {
            favorites.addAll({
              element.id!: element.inFavorites!,
            });
          }
          emit(ShopSuccessHomeDataState());
        }).catchError((error) {
          print(error.toString());
          emit(ShopErrorHomeDataState());
        });
      } else {
        emit(ShopConnectionErrorState());
      }
    });
  }

  CategoriesModel? categoriesModel;
  Future<void> getCategories() async {
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        categoriesModel = null;
        await DioHelper.getData(url: 'categories').then((value) {
          categoriesModel = CategoriesModel.fromJson(value.data);
          emit(ShopSuccessCategoriesState());
        }).catchError((error) {
          emit(ShopErrorCategoriesState());
        });
      } else {
        emit(ShopConnectionErrorState());
      }
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorites(int productId, context) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopSuccessChangeFavoritesState());

    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if (!changeFavoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
        showSnackBar(context, changeFavoriteModel!.message, SnackState.ERROR);
      } else {
        getFavorites();
      }
      print(changeFavoriteModel!.message);
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  Future<void> getFavorites() async {
    emit(ShopLoadingFavoritesState());
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        favoritesModel = null;
        await DioHelper.getData(url: 'favorites',token: token).then((value) {
          favoritesModel = FavoritesModel.fromJson(value.data);
          emit(ShopSuccessFavoritesState());
        }).catchError((error) {
          print(error.toString());
          emit(ShopErrorFavoritesState());
        });
      } else {
        emit(ShopConnectionErrorState());
      }
    });
  }

  UserDataModel? userDataModel;

  Future<void> getUserData() async {
    emit(ShopLoadingUserDataState());
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        userDataModel = null;
        await DioHelper.getData(url: 'profile',token: token).then((value) {
          userDataModel = UserDataModel.fromJson(value.data);
          emit(ShopSuccessUserDataState());
        }).catchError((error) {
          emit(ShopErrorUserDataState());
        });
      } else {
        emit(ShopConnectionErrorState());
      }
    });
  }

  FQAModel? fqaModel;

  Future<void> getFQA() async {
    emit(ShopLoadingFQAState());
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        fqaModel = null;
        await DioHelper.getData(url: 'faqs').then((value) {
          fqaModel = FQAModel.fromJson(value.data);
          emit(ShopSuccessFQAState());
        }).catchError((error) {
          emit(ShopErrorFQAState());
        });
      } else {
        emit(ShopConnectionErrorState());
      }
    });
  }

  var editFormKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  UpdateUserModel? updateUserModel;

  Future<void> updateUserData(context) async {
    emit(ShopLoadingUpdateUserState());
    checkConnection().then((value) async {
      if (value != ConnectivityResult.none) {
        updateUserModel = null;
        await DioHelper.putData(url: 'update-profile',token: token,data: {
          'name':nameController.text,
          'phone':phoneController.text,
          'email':emailController.text
        }).then((value) {
          updateUserModel = UpdateUserModel.fromJson(value.data);
          if(updateUserModel!.status!) {
            emailController.text = updateUserModel!.data!.email!;
            phoneController.text = updateUserModel!.data!.phone!;
            nameController.text = updateUserModel!.data!.name!;
            userDataModel = UserDataModel.fromJson(value.data);
            showSnackBar(context, updateUserModel!.message, SnackState.SUCCESS);
          }else {
            showSnackBar(context, updateUserModel!.message, SnackState.ERROR);
          }
          emit(ShopSuccessUpdateUserState());
        }).catchError((error) {
          print(error);
          emit(ShopErrorUpdateUserState());
        });
      } else {
        emit(ShopConnectionErrorState());
      }
    });
  }

  var editPasswordFormKey = GlobalKey<FormState>();

  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var repeatNewPasswordController = TextEditingController();

  bool oldPasswordHide = true;
  bool newPasswordHide = true;
  bool repeatPasswordHide = true;

  void changePasswordShow(int passNum){
    if(passNum == 1) {
      oldPasswordHide = !oldPasswordHide;
    }else if(passNum == 2) {
      newPasswordHide = !newPasswordHide;
    }else if(passNum == 3) {
      repeatPasswordHide = !repeatPasswordHide;
    }
    emit(ShopChangePasswordShowState());
  }

  ChangePasswordModel? changePasswordModel;


  void changePassword(context, String oldPassword, String newPassword ) {
    emit(ShopLoadingChangePasswordState());

    DioHelper.postData(
      url: 'change-password',
      data: {
        'current_password': oldPassword,
        'new_password': newPassword,
      },
      token: token,
    ).then((value) {
      changePasswordModel = ChangePasswordModel.fromJson(value.data);

      if(changePasswordModel!.status!) {
        oldPasswordController.text = '';
        newPasswordController.text = '';
        repeatNewPasswordController.text = '';
        showSnackBar(context, changePasswordModel!.message, SnackState.SUCCESS);
      }else {
        showSnackBar(context, changePasswordModel!.message, SnackState.ERROR);
      }
      print(changePasswordModel!.message);
      emit(ShopSuccessChangePasswordState());
    }).catchError((error) {
      emit(ShopErrorChangePasswordState());
    });
  }

  var searchController = TextEditingController();


  ShopSearchModel? shopSearchModel;


  void getSearch(String q) {
    emit(ShopLoadingGetSearchState());

    DioHelper.postData(
      url: 'products/search',
      data: {
        'text': q
      },
    ).then((value) {
      shopSearchModel = ShopSearchModel.fromJson(value.data);
      print(shopSearchModel!.message);
      emit(ShopSuccessGetSearchState());
    }).catchError((error) {
      print(error);
      emit(ShopErrorGetSearchState());
    });

  }

  ProductModel? productModel;

  void getProduct(int productId) {

    emit(ShopLoadingGetProductState());

    DioHelper.getData(
      url: 'products/$productId',
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel!.message);
      emit(ShopSuccessGetProductState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorGetProductState());
    });
  }



  void getCarts(int productId) {

    emit(ShopLoadingGetProductState());

    DioHelper.postData(
      url: 'products/$productId',
      data: {
        'product_id' : productId
      },
      token: token,
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel!.message);
      emit(ShopSuccessGetProductState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorGetProductState());
    });
  }

  void addToCart(int productId) {

    emit(ShopLoadingGetProductState());

    DioHelper.postData(
      url: 'products/$productId',
      data: {
        'product_id' : productId
      },
      token: token,
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel!.message);
      emit(ShopSuccessGetProductState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorGetProductState());
    });
  }

  void updateCart(int productId) {

    emit(ShopLoadingGetProductState());

    DioHelper.postData(
      url: 'products/$productId',
      data: {
        'product_id' : productId
      },
      token: token,
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel!.message);
      emit(ShopSuccessGetProductState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorGetProductState());
    });
  }

  void deleteCart(int productId) {

    emit(ShopLoadingGetProductState());

    DioHelper.getData(
      url: 'products/$productId',
    ).then((value) {
      productModel = ProductModel.fromJson(value.data);
      print(productModel!.message);
      emit(ShopSuccessGetProductState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorGetProductState());
    });
  }
}
