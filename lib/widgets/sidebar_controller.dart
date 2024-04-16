import 'package:careno_admin/view/layouts/layout_active_vehicles.dart';
import 'package:careno_admin/view/layouts/layout_categories_list.dart';
import 'package:careno_admin/view/layouts/layout_customers_list.dart';
import 'package:careno_admin/view/layouts/layout_dashboard.dart';
import 'package:careno_admin/view/layouts/layout_logout.dart';
import 'package:careno_admin/view/layouts/layout_promotional_banner.dart';
import 'package:careno_admin/view/layouts/layout_providers_list.dart';
import 'package:careno_admin/view/layouts/layout_providers_requests.dart';
import 'package:careno_admin/view/layouts/layout_settings.dart';
import 'package:careno_admin/view/layouts/layout_vehicles_requests.dart';
import 'package:careno_admin/widgets/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SidebarController extends GetxController{
  RxInt _index = 0.obs;

  int get index => _index.value;

  set setIndex(int index) => _index.value = index;

  List<Sidebar> get item => [
    Sidebar(icon: "assets/icons/dashboard.svg", title: "Dashboard",fontSize: 16),
    Sidebar(icon: "assets/icons/category.svg", title: "Category",fontSize: 16),
    Sidebar(icon: "assets/icons/customer.svg", title: "Customer List",fontSize: 16),
    Sidebar(icon: "assets/icons/provider.svg", title: "Provider List",fontSize: 16),
    Sidebar(icon: "assets/icons/providerRequest.svg", title: "Provider Request",fontSize: 14),
    Sidebar(icon: "assets/icons/vehicleRequest.svg", title: "Vehicle Request",fontSize: 14),
    Sidebar(icon: "assets/icons/activeVehicel.svg", title: "Active Vehicle",fontSize: 14),
    Sidebar(icon: "assets/icons/banner.svg", title: "Promotional Banner",fontSize: 14),
    Sidebar(icon: "assets/icons/setting.svg", title: "Settings",fontSize: 14),
    Sidebar(icon: "assets/icons/logout.svg", title: "Logout",fontSize: 16),
  ];

  List<Widget> get screen => [
    //  Layouts name call here

    LayoutDashboard(),
    LayoutCategoriesList(),
    LayoutCustomersList(),
    LayoutProvidersList(),
    LayoutProvidersRequests(),
    LayoutVehiclesRequests(),
    LayoutActiveVehicles(),
    LayoutPromotionalBanner(),
    LayoutSettings(),
    LayoutLogout()

  ];
}