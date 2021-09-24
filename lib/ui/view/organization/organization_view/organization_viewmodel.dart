import 'package:hng/app/app.locator.dart';
import 'package:hng/app/app.logger.dart';
import 'package:hng/app/app.router.dart';
import 'package:hng/models/organization_model.dart';
import 'package:hng/package/base/server-request/Organization_request/Organization_api_service.dart';
import 'package:hng/services/connectivity_service.dart';
import 'package:hng/services/local_storage_services.dart';
import 'package:hng/utilities/enums.dart';
import 'package:hng/utilities/storage_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OrganizationViewModel extends BaseViewModel {
  final log = getLogger('OrganizationViewModel');
  final navigation = locator<NavigationService>();
  final snackbar = locator<SnackbarService>();
  final connectivityService = locator<ConnectivityService>();
  final storageService = locator<SharedPreferenceLocalStorage>();
  final api = OrganizationApiService();
  List<OrganizationModel> organizations = [];

  void initViewModel() {
    fetchOrganizations();
  }

  Future<void> navigateToNewOrganization() async {
    try {
      await navigation.navigateTo(Routes.addOrganizationView);
      organizations = await api.fetchListOfOrganizations();
      filterOrganization();
      notifyListeners();
    } catch (e) {
      snackbar.showCustomSnackBar(
        duration: const Duration(seconds: 3),
        variant: SnackbarType.failure,
        message: 'Error Updating Organizations',
      );
    }
  }

  //Returns the list of Organization the user is part of
  Future fetchOrganizations() async {
    if (!await connectivityService.checkConnection()) {
      snackbar.showCustomSnackBar(
        duration: const Duration(seconds: 3),
        variant: SnackbarType.failure,
        message: 'Check your internet connection',
      );

      return;
    }

    try {
      setBusy(true);
      final resFromApi = await api.getJoinedOrganizations();
      if (resFromApi.isEmpty) {
        organizations = [];
      } else {
        organizations = resFromApi;
      }
      // filterOrganization();

      setBusy(false);
    } catch (e) {
      log.i(e.toString());
      snackbar.showCustomSnackBar(
        duration: const Duration(seconds: 3),
        variant: SnackbarType.failure,
        message: 'Error Occured',
      );
    }
  }

//TODO change this to fetch the list of organizations the user is part of alone
  void filterOrganization() {
    final ids = storageService.getStringList(StorageKeys.organizationIds) ?? [];
    organizations.retainWhere((e) => ids.any((id) => id == e.id));
  }

  Future<void> onTap(String? id, String? name, String? url) async {
    try {
      if (id == currentOrgId) {
        navigation.replaceWith(Routes.navBarView);
        return;
      }
      await checkSnackBarConnectivity();

      await storageService.setString(StorageKeys.currentOrgId, id!);
      snackbar.showCustomSnackBar(
        duration: const Duration(seconds: 3),
        variant: SnackbarType.success,
        message: 'You have entered $name',
      );
      storageService.setString(StorageKeys.currentOrgName, name!);
      storageService.setString(StorageKeys.currentOrgUrl, url!);

      navigation.replaceWith(Routes.navBarView);
    } catch (e) {
      log.i(e.toString());
      snackbar.showCustomSnackBar(
        duration: const Duration(seconds: 3),
        variant: SnackbarType.failure,
        message: 'Error fetching Organization Info',
      );
    }
  }

  checkSnackBarConnectivity() async {
    if (!await connectivityService.checkConnection()) {
      snackbar.showCustomSnackBar(
        duration: const Duration(seconds: 3),
        variant: SnackbarType.failure,
        message: 'Check your internet connection',
      );
      return;
    }
  }

  String? get currentOrgId =>
      storageService.getString(StorageKeys.currentOrgId);
}