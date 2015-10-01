//
//  MailboxViewController.swift
//  cp-3-Mailbox
//
//  Created by Sebastian Drew on 10/1/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var singleMessageView: UIView!
    @IBOutlet weak var MailListView: UIView!

    var singleMessageInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scrollView.delegate = self
        
        singleMessageInitialCenter = singleMessageView.center
        
        rescheduleView.alpha = 0
        listView.alpha = 0

        scrollView.contentSize = CGSize(width: 320, height: 1000)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Scrollview Methods
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(self.view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            NSLog("began panning to")
            singleMessageInitialCenter = singleMessageView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            NSLog("currently panned to")
            singleMessageView.center = (CGPoint(x: singleMessageInitialCenter.x + translation.x, y: singleMessageInitialCenter.y))
           
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            NSLog("ended panning to")
            
            
        }

    }

}
