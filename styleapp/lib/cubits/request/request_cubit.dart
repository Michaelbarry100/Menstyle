import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:styleapp/data/repo/repos.dart';

import '../../api/storage.dart';
import '../../bloc/app/app_bloc.dart';
import '../../data/models/models.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  
  final ApplicationBloc appBloc;
  RequestCubit({required this.appBloc}) : super(RequestInitiated());

  late DataRepo dataRepo = DataRepo(appBloc.dioInstance);
  final StorageUtil storageUtil = StorageUtil();

  Future<void> getCollections() async {
    try {
      emit(RequestLoading());
      var response = await dataRepo.collections();
      List collections = response['data'].map((collectionData) {
        return Collection.fromJson(collectionData);
      }).toList();

      emit(RequestApproved(data: collections));
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
    }
  }

  Future<void> getCategories({ int? collectionId }) async {
    // try {
      emit(RequestLoading());
      var response = await dataRepo.categories(collection: collectionId);
      List categories = response['data'].map((categoryData) {
        return Category.fromJson(categoryData);
      }).toList();
      emit(RequestApproved(data: categories));
    // } catch (e) {
    //   emit(RequestFailed(message: e.toString()));
    // }
  }

  Future<void> getStyles({int? categoryId, required int page, bool isPremium = false }) async {
    try {
      emit(RequestLoading());
      var response = await dataRepo.styles(category: categoryId, page: page, premium: isPremium );
      var data = response['data'] as Map;

      List styles = data['data'].map((styleData) {
        return Style.fromJson(styleData);
      }).toList();
      
      emit(RequestApproved(data: { ...data, "data": styles }));
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
    }
  }

  Future<void> loadHomeData() async {
    try {
        emit(RequestLoading());
       var response = await dataRepo.landing();
      emit(RequestApproved(data: response['data']));
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
    }
  }

  
  // Favourites
  Future<void> getFavouriteStyles() async {
    try {
      emit(RequestLoading());
      String favoriteStr = await storageUtil.getStrVal('favorites');
      if(favoriteStr.isEmpty) {
        emit(const RequestApproved(data: []));
      }else {
        var favorites = json.decode(favoriteStr) as List;
        List styles = favorites.map((styleData) {
          return Style.fromJson(json.decode(styleData));
        }).toList();
        emit(RequestApproved(data: styles));
      }
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
    }
  }

  Future<void> addToFavourites(Style style) async {
    try {
      emit(SavingStyle());
      String favoriteStr = await storageUtil.getStrVal('favorites');
      if(favoriteStr.isEmpty) {
        List favorites = [
          style.toJson()
        ];
        await storageUtil.setStrVal('favorites', json.encode(favorites));
      }else {
        var favorites = json.decode(favoriteStr) as List;
        favorites.add(style.toJson());
        await storageUtil.setStrVal('favorites', json.encode(favorites));
      }
      emit(SavedStyle());
    } catch (e) {
      emit(RequestFailed(message: e.toString()));
    }
  }
}
