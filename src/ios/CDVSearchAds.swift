import iAd

@available(iOS 10.0, *)
@objc(CDVSearchAds) class CDVSearchAds : CDVPlugin {
    fileprivate func sendResult(_ pluginResult : CDVPluginResult, callbackId : String) {
        pluginResult.setKeepCallbackAs(false)
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: callbackId
        )
    }
    
    @objc func initialize(_ command:CDVInvokedUrlCommand) {
        DispatchQueue.global().async {
            ADClient.shared().requestAttributionDetails({ (attributionDetails, error) in
                if error == nil {
                    for (type, adDictionary) in attributionDetails! {
                        let attribution = adDictionary as? Dictionary<AnyHashable, Any>;
                        
                        let pluginResult = CDVPluginResult(
                            status: CDVCommandStatus_OK,
                            messageAs : attribution
                        )

                        self.sendResult(pluginResult!, callbackId: command.callbackId!);
                    }
                } else {
                    let pluginResult = CDVPluginResult(
                        status : CDVCommandStatus_ERROR,
                        messageAs : "Can't get Search Ads Attribution Information"
                    );

                    self.sendResult(pluginResult!, callbackId: command.callbackId!);
                }
            })
        }
    }
}
