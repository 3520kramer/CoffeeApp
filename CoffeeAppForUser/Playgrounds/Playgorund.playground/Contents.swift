import UIKit

var distance = 556.885

(distance / 10).rounded(.down)*10

distance.rounded()

var distanceRounded = String(format: "%.1f", distance)

distance = 1520.33

(distance / 100).rounded(.down)/10

var number = 40.00
floor(number)
if (number - floor(number) > 0.01) { 
    print("with decimal")
}else{
    print("no decimal")
}

var word: NSMutableString = "123456"

word.insert(":", at: 4)
word.insert(":", at: 2)

print(word)
