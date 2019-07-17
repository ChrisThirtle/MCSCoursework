import Foundation

struct BigInt: CustomStringConvertible {
  
  var intString: String
  var description: String {
    return intString
  }
  
  static let strideSize = 1
  
  init(_ value: Int) {
    self.intString = String(value)
  }
  
  init(_ intString: String) {
    self.intString = intString
  }
  static func *(lhs: BigInt, rhs: BigInt) -> BigInt {
    var outputArray = [Int](repeating: 0, count: lhs.intString.count + rhs.intString.count + 1)
    var carry = 0
    for (lhIndex, lhChar) in lhs.intString.reversed().enumerated() {
      let lhInt = Int(String(lhChar)) ?? 0
      carry = 0
      for (rhIndex, rhChar) in rhs.intString.reversed().enumerated() {
        let rhInt = Int(String(rhChar)) ?? 0
        let product = lhInt * rhInt + carry
        outputArray[lhIndex + rhIndex] += product
        carry = outputArray[lhIndex + rhIndex] / 10
        outputArray[lhIndex + rhIndex] = outputArray[lhIndex + rhIndex] % 10
      }
      outputArray[lhIndex + rhs.intString.count] += carry
    }
    var outputString = ""
    var leadingZeroes = true
    for digit in outputArray.reversed() {
      if leadingZeroes && digit == 0 { continue }
      leadingZeroes = false
      outputString.append(String(digit))
    }
    return BigInt(outputString)
  }
  
  static func *(lhs: BigInt, rhs: Int) -> BigInt {
    return lhs * BigInt(rhs)
  }
  
  static func *(lhs: Int, rhs: BigInt) -> BigInt {
    return BigInt(lhs) * rhs
  }
}

func factorial(of number: Int) -> BigInt {
  var result = BigInt(1)
  for factor in 2...number {
    result = result * BigInt(factor)
  }
  return result
}

print(factorial(of: 100))
