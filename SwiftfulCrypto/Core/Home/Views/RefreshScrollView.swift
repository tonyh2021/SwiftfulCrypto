//
//  RefreshScrollView.swift
//  SwiftfulCrypto
//
//  Created by Tony on 2023-03-23.
//

import Foundation
import SwiftUI

struct RefreshScrollView: UIViewRepresentable {
    let width: CGFloat
    let height: CGFloat
    let vm: HomeViewModel
    let onTap: OnTapCallback
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self, vm: vm)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
        
        let childView = UIHostingController(rootView: PullToRefreshView(vm: vm, onTap: onTap))
        
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        control.addSubview(childView.view)
        return control
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) { }
    
    class Coordinator: NSObject {
        var control: RefreshScrollView
        var vm: HomeViewModel
        init(_ control: RefreshScrollView, vm: HomeViewModel) {
            self.control = control
            self.vm = vm
        }
        
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            sender.endRefreshing()
            vm.reloadData()
        }
    }
}
