abstract class BankAccount{
  final int _actNumber;
  final String _actName;
  final double _balance;

  BankAccount({
    required this._actNumber,
    required this._actName,
    required this._balance
  });

  int get getactNumber{
    return _actNumber;
  }
  set setactNumber(int actNumber){
    _actNumber=actNumber;
  }

  String get getactName{
    return _actName;
  }
  set setactName(String actName){
    _actName=actName;
  }
  int get getBalance{
    return _balance;
  }
  set setBalance(double balance){
    _balance=balance;
  }

  void withdraw(double amount);
  void deposit(double amount);

  void displayInfo(){
    print("Accont Number:$_actNumber");
    print("Accont Holder Name:$_actName");
    print("Balancer:$_balance");


  }

  void updateBalance(double newAmount){
    _balance=newAmount;
  }


}

abstract class InterestBearing{
  void calculateInterest();
}

//Saving Account

class SavingsAccount extends BankAccount implements InterestBearing{

  static const double _minBalance = 500;
  static const double _interrestRate=0.02;
  int _withdrawalCount= 0;
  static const int _withdrawalLimit=3;

  SavingsAccount({
    required super._actNumber,
    required super._actName,
    required super._balance

  });

  @override
  void deposit(double amount) {
    if(amount>0){
      updateBalance(_balance+amount);
      print("\$$amount deposited into Saving Account");
    }else{
      print("Deposit amount should be positive.");
    }



  }

  @override
  void withdraw(double amount) {
    if(_withdrawalCount>=_withdrawalLimit){
      print("Withdrawl limit reached for this month.");
      return;
    }
    if(_balance-amount<_minBalance){
      print("Cannot withdraw: Mininum withdraw amount is \$$_minBalance");
    }
    updateBalance(_balance - amount);
    _withdrawalCount++;
    print("Amount of \$$amount withdrawn from Saving Account");
    
  }
  
  @override
  void calculateInterest() {
    double interestAmt = _balance*_interrestRate;
    updateBalance(_balance+interestAmt);
    print("Interest of \$$interestAmt was added.");
    
  }
  
}

//Checking Account

class CheckingAccount extends BankAccount{
  static const _overdraftFee=35;

  CheckingAccount({
    required super._actNumber,
    required super._actName,
    required super._balance

  });


  @override
  void deposit(double amount) {
    if(amount>0){
      updateBalance(_balance+amount);
      print("$amount deposited into Current Account");
    }else{
      print("Deposit amount should be positive.");
    }
  }


  @override
  void withdraw(double amount) {
    if(amount<=0){
      print("Invaild withdraw amount.");
      return;
    }
    updateBalance(_balance-amount);
    if(_balance<0){
      updateBalance(_balance-_overdraftFee);
      print("\$$_overdraftFee was detucted from your account.");
    }
    print("Amount of \$$amount was withdrawn from Saving Account.")
  }


}