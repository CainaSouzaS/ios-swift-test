//
//  Router.swift
//  TestApp
//
//  Created by Cainã Souza on 2018-07-23.
//  Copyright © 2018 AlayaCare. All rights reserved.
//

import UIKit

public enum Storyboards: String {
    case main = "Main"
}

/* Define your routes here. For Login in Storyboard, add the LoginController identifier. You can then access it using Route.routeLogin.identifier.
 For Segues beetween screens name it like : FirstToSecond, then use : Route.routeFirst.to(.routeSecond)
 */
public enum Route: String {
    case note = "Note"
    
    /*! Return the view controller identifier */
    public var identifier: String {
        return "\(self.rawValue)Controller"
    }
    
    /*! Return the segue associated to the destination ex: LoginToSignup */
    public func to(_ to: Route) -> String {
        return "\(self.rawValue)To\(to.rawValue)"
    }
}

/**
 * Initialize a view controller from a route and storyboard
 *
 * - parameter route: The Route being navigated to.
 * - parameter storyboard: The storyboard where the view controller is located.
 */
public func controller(for route: Route, from storyboard: Storyboards) -> UIViewController? {
    let controller = UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: route.identifier)
    
    return controller
}
