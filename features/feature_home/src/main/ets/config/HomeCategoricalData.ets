import { PagePathConstants } from '@ohos/global_constant'

export interface Category {
  title: Resource,
  childNodes: SubCategory[]
}

export interface SubCategory {
  title: Resource,
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
  ];

export const HOME_CATEGORIES: Category[] =
  [
    { title: $r('app.string.common_example'), childNodes: COMMON_EXAMPLES },
  ];


