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

  void updateBlance(double newAmount){
    _balance=newAmount;
  }


}

abstract class InterestBearing{
  void calculateInterest();
}


class SavingsAccount extends BankAccount implements InterestBearing{

  static const double _minBalance = 500;
  static const double _interrestRate=0.02;
  int _withdrawalCount= 0;
  static const int _withdrawalLimit=3;

  SavingsAccount({
    required super._actNumber,
    required super._actName,
    required super._balance,

  });




  @override
  void deposit(double amount) {
    if(amount>0){
      updateBlance(_balance+amount);
      print("Rs.$amount deposited into Saving Account");
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
      print("Cannot withdraw: Mininum withdraw amount is $_minBalance");
    }
  }
  
  @override
  void calculateInterest() {
    // TODO: implement calculateInteres
  }
  
}

class CheckingAccount extends BankAccount{
  @override
  double deposit() {
    // TODO: implement deposit
    throw UnimplementedError();
  }

  @override
  double withdraw() {
    // TODO: implement withdraw
    throw UnimplementedError();
  }

}

class PremiumAccount extends BankAccount{
  @override
  double deposit() {
    // TODO: implement deposit
    throw UnimplementedError();
  }

  @override
  double withdraw() {
    // TODO: implement withdraw
    throw UnimplementedError();
  }

}