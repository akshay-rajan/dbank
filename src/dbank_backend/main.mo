// Import from the motoko base library
import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

// Class holding the canister
actor DBank {
  // Variable holding current amount stored
  // stable var currentValue = 300;
  stable var currentValue: Float = 300;
  
  // Replace the current value of a variable with a new value
  currentValue := 100;

  // Constant
  // let id = 283428289218710;

  // Print to the terminal
  // debug_show is for printing values that are not strings
  Debug.print(debug_show(currentValue));

  // Public Function
  public func topUp(amount: Float) {
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };  // ';' ends the block

  public func withdraw(amount: Float) {
    // After subtraction, the type may not be Nat
    // Hence, we need to specify the datatype
    let temp: Float = currentValue - amount;
    if (temp >= 0) {
      currentValue -= amount;
    };
    Debug.print(debug_show(currentValue));
  };


  // Query Function
  public query func checkBalance(): async Float {
    
    return currentValue;

  };

  // Time
  stable var startTime = Time.now();

  public func compound() {
    let currentTime = Time.now();
    let timeElapsed = currentTime - startTime;
    let timeElapsedInS = timeElapsed / 1000000000;

    // Compound interest of 1% per second
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedInS));
    startTime := currentTime;
  };

}
