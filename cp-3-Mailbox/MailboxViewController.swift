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
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var returnContentButton: UIButton!
    @IBOutlet weak var sendContentView: UIButton!
    @IBOutlet weak var singleMessage: UIImageView!
    
    @IBOutlet weak var parentView: UIView!

    var singleMessageInitialCenter: CGPoint!
    var contentViewInitialCenter: CGPoint!
    
    var contentViewInitialX: CGFloat!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // scrollView.delegate = self
        
        singleMessageInitialCenter = singleMessageView.center
        contentViewInitialCenter = contentView.center
        contentViewInitialX = contentView.frame.origin.y
        
        rescheduleView.alpha = 0
        listView.alpha = 0
        // contentView.alpha = 0.4
        sendContentView.enabled = true
        sendContentView.hidden = false

        scrollView.contentSize = CGSize(width: 320, height: 1000)
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        
        edgeGesture.edges = UIRectEdge.Left
        
       contentView.addGestureRecognizer(edgeGesture)
        
        let parentEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "parentEdgeGesture:")
        
        parentEdgeGesture.edges = UIRectEdge.Right
        
        parentView.addGestureRecognizer(parentEdgeGesture)
        
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
    
    @IBAction func onRescheduleTap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.rescheduleView.alpha = 0
        }
    }
    
    @IBAction func onMessagePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(self.view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
           // NSLog("began panning to")
            singleMessageInitialCenter = singleMessage.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
          //  NSLog("currently panned to")
            singleMessage.center = (CGPoint(x: singleMessageInitialCenter.x + translation.x, y: singleMessageInitialCenter.y))
            
            if singleMessageInitialCenter.x < 120 {
                UIView.animateWithDuration(0.4) { () -> Void in
                    // self.singleMessageView.alpha = 0
                   self.rescheduleView.alpha = 1
                    self.singleMessageView.backgroundColor = UIColor.redColor()
                    NSLog("dammit")
                }
                
            }
           
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
          //  NSLog("ended panning to")
             UIView.animateWithDuration(0.3) { () -> Void in
                
            }
            
          if singleMessageInitialCenter.x < 120 {
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.singleMessage.center.x = -130
                }, completion: nil)
            }

            
            /*
UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: CGFloat(0.8), initialSpringVelocity: CGFloat(50), options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.singleMessageView.center = self.singleMessageInitialCenter
                }, completion: nil)
*/
            
        }

    }
    
    @IBAction func sendContentView(sender: AnyObject) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.parentView.center.x = 430
        }
    }
    
    @IBAction func returnContentView(sender: AnyObject) {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.contentView.center.x = 160
        }
    }
    
    @IBAction func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        // let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
             // NSLog("ended XXXX to")
            contentViewInitialCenter = parentView.center
        } else if sender.state == UIGestureRecognizerState.Changed {
            
           // NSLog("currently XXXX to")
            parentView.center = (CGPoint(x: contentViewInitialCenter.x + translation.x, y: contentViewInitialCenter.y))
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
          //  NSLog("ended XXXX to")
            if parentView.center.x > 240 {
                print("x")
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.parentView.center.x = 430
                })
                sendContentView.enabled = false
                sendContentView.hidden = true
                contentView.userInteractionEnabled = false
                
            } else {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.parentView.center.x = 160
                })

            }
            
//            else if velocity.x < 0 {
//                print("y")
//                UIView.animateWithDuration(0.4, animations: { () -> Void in
//                    self.contentView.center.x = 0
//                })
//            }

        }
    }
    
    @IBAction func parentEdgeGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = 
        
        if sender.state == UIGestureRecognizerState.Began {
            
            // ...
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            // ..
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // ..
            
        }

        
        
    }
}
