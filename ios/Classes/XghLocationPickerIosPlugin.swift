import Flutter
import UIKit
import Foundation
import CoreLocation

public class XghLocationPickerIosPlugin: NSObject, FlutterPlugin {
    
    var location: CLLocation?

    public static func register(with registrar: any FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "xgh_location_picker_ios", binaryMessenger: registrar.messenger())
        let instance = XghLocationPickerIosPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
          case "openLocationPicker":
          alterarLocalizacao(result: result)
        default:
          result(FlutterMethodNotImplemented)
        }
    }

    func alterarLocalizacao(result: @escaping FlutterResult) {
        var canExecute = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            canExecute = true
        }
          let alert = UIAlertController(style: .actionSheet)
          alert.addCustomLocationPicker { local in
              if canExecute{
                  canExecute = false
                  self.location = CLLocation(latitude: local!.coordinate.latitude, longitude: local!.coordinate.longitude)
                  result("\(local!.coordinate.latitude), \(local!.coordinate.longitude)")
                  print("Location: \(local!.coordinate.latitude), \(local!.coordinate.longitude)")
              }
          }

          configureAlertControllerConstraints(alert: alert)
          alert.addAction(title: "Cancelar", style: .cancel)
          alert.show()
    }

  func configureAlertControllerConstraints(alert:UIAlertController){
      if UIDevice.current.userInterfaceIdiom == .pad {
          // Filtering width constraints of alert base view width
          let widthConstraints = alert.view.constraints.filter({ return $0.firstAttribute == .width })
          alert.view.removeConstraints(widthConstraints)
          // Here you can enter any width that you want
          let newWidth = UIScreen.main.bounds.width * 0.70
          // Adding constraint for alert base view
          let widthConstraint = NSLayoutConstraint(item: alert.view!,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1,
                                                   constant: newWidth)
          alert.view.addConstraint(widthConstraint)
          let firstContainer = alert.view.subviews[0]
          // Finding first child width constraint
          let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
          firstContainer.removeConstraints(constraint)
          // And replacing with new constraint equal to alert.view width constraint that we setup earlier
          alert.view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: alert.view,
                                                      attribute: .width,
                                                      multiplier: 1.0,
                                                      constant: 0))
          // Same for the second child with width constraint with 998 priority
          let innerBackground = firstContainer.subviews[0]
          let innerConstraints = innerBackground.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
          innerBackground.removeConstraints(innerConstraints)
          firstContainer.addConstraint(NSLayoutConstraint(item: innerBackground,
                                                          attribute: .width,
                                                          relatedBy: .equal,
                                                          toItem: firstContainer,
                                                          attribute: .width,
                                                          multiplier: 1.0,
                                                          constant: 0))
      }
  }
}

