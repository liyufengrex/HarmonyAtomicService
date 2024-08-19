import { PagePathConstants } from '@ohos/global_constant'

export interface Category {
  title: Resource,
  childNodes: SubCategory[]
}

export interface SubCategory {
  title: Resource | string,
  url?: string,
}

export const COMMON_EXAMPLES: SubCategory[] =
  [
    {
      title: $r('app.string.http_example'),
      url: PagePathConstants.PAGE_HTTP_REQUEST,
    },
    {
      title: $r('app.string.event_bus_example'),
      url: PagePathConstants.PAGE_EVENT_BUS,
    },
    {
      title: $r('app.string.custom_dialog_example'),
      url: PagePathConstants.PAGE_CUSTOM_DIALOG,
    },
    {
      title: $r('app.string.router_callback_example'),
      url: PagePathConstants.PAGE_ROUTER_CALLBACK,
    },
    {
      title: $r('app.string.throttle_example'),
      url: PagePathConstants.PAGE_THROTTLE_TEST,
    },
    {
      title: $r('app.string.permission_example'),
      url: PagePathConstants.PAGE_PERMISSION_TEST,
    },
    {
      title: $r('app.string.dynamic_router_example'),
      url: PagePathConstants.DYNAMIC_ROUTER_TEST,
    },
    {
      title: $r('app.string.dynamic_ui_node_example'),
      url: PagePathConstants.DYNAMIC_UI_NODE_TEST,
    },
    {
      title: $r('app.string.fix_fold_ui_example'),
      url: PagePathConstants.FIX_FOLD_UI_EXAMPLE,
    },
    {
      title: $r('app.string.component_factory_example'),
      url: PagePathConstants.COMPONENT_FACTORY_EXAMPLE,
    },
    {
      title: $r('app.string.attribute_modifier_example'),
      url: PagePathConstants.ATTRIBUTE_MODIFIER_EXAMPLE,
    },
    {
      title: $r('app.string.cloud_function_example'),
      url: PagePathConstants.CLOUD_FUNCTION_EXAMPLE,
    },
    {
      title: $r('app.string.cloud_data_base_example'),
      url: PagePathConstants.CLOUD_DATA_BASE_EXAMPLE,
    },
  ];

export const HOME_CATEGORIES: Category[] =
  [
    { title: $r('app.string.common_example'), childNodes: COMMON_EXAMPLES },
  ];


