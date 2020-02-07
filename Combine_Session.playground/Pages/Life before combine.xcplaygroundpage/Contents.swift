//: [Previous](@previous)

//:# Control Flow

//: ![ControlFlows](Notification.png)

/*:
 - Any Architecture require Binding
 - Binding is not default or sometimes bi-directional
 * Threading issue might occur while doing asyncronous Update
*/

/*:
 Example Consider you want to do some thing as below

   * begin
     * var name = "Tom"
     * print(name)
     * name += " Harding"
     * print(name)
   * end
 
*/

/*:
 
 What happens when working Asynchronously
 * --- Thread 1 ---
    * begin
        * var name = "Tom"
        * print(name)

* --- Thread 2 ---
    * name = "Billy Bob"

* --- Thread 1 ---
    * name += " Harding"
    * print(name)
 
 * end
 
 */

//: ![](SwiftUI.png)

/*:
 The above scenario is common case when using multiThreading/Concurrency. This can be avoided by using reactive Programming. One such effort by apple is combine
 
 
 
 */

//: [Publisher](@next)
