# Cordova/Ionic Search Ads API Plugin

## TL;DR
The Search Ads API plugin for Cordova/Ionic didn't exist, so I created it. You can [check out the code on Github]() and read onward for an example on how to use it.

> You can also check out the step by step tutorial about [How to create a **native iOS app** that can read Search Ads Attribution API information](http://www.nikola-breznjak.com/blog/ios/create-native-ios-app-can-read-search-ads-attribution-api-information/) if you're not into hybrid solutions 😯.

## What is Search Ads App Attribution?
From [Apple's documentation](https://searchads.apple.com/help/pdf/attribution-api.pdf):

> Search Ads App Attribution enables developers to track and attribute app downloads that originate from Search Ads campaigns. With Search Ads App Attribution, iOS developers have the ability to accurately measure the lifetime value of newly acquired users and the effectiveness of their advertising campaigns.

## How to use the plugin
If you want to test this on a blank project, you can create a new Ionic project like this:

`ionic start ionicSearchAdsDemo tabs`

Since the plugin has been added to [npm repository](), you can simply add it like this:

`ionic plugin add cordova-plugin-searchads`

Add the following code in the `controllers.js` file under the `DashCtrl` controller:

```
.controller('DashCtrl', function($scope, $ionicPlatform) {
    $scope.data = 'no data';

    $ionicPlatform.ready(function() {
        if (typeof SearchAds !== "undefined") {
            searchAds = new SearchAds();

            searchAds.initialize(function(attribution) {
                console.dir(attribution); // do something with this attribution (send to your server for further processing)
                $scope.data = JSON.stringify(attribution);
            }, function (err) {
                console.dir(err);
            });
        }
    });
})
```

Replace the content of the `templates/tab-dash.html` file with this:

```
<ion-view view-title="Dashboard">
  <ion-content class="padding">
    <div class="card">
      <div class="item item-text-wrap">
        {{data}}
      </div>
    </div>
  </ion-content>
</ion-view>
```

Prepare the project by executing the following command in your terminal:

`ionic prepare ios && open platforms/ios`

After this, open up the XCode project (`*.xcodeproj`) file:

![](https://i.imgur.com/jqxYHFs.png)

Make sure the `iAd.framework` has been added under Linked frameworks and Libraries:

![](https://i.imgur.com/fvRkNQU.png)

This should have happened automatically when you've added the plugin, but it's good to make sure. Add it yourself if you don't see it here.

Run the project on your device and you should get something like this:

![](https://i.imgur.com/tdnkgqb.png)

There, hope this proves to be useful to someone! 💪