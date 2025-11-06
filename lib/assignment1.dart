abstract class BankAccount{
  String _actNumber;
  String _actName;
  double _balance;

  BankAccount({
    required this._actNumber,
    required this._actName,
    required this._balance
  });

  int get accountNumber{
    return _actNumber;
  }
  set setactNumber(int actNumber){
    _actNumber=actNumber;
  }

  String get holderName{
    return _actName;
  }
  set setactName(String actName){
    _actName=actName;
  }
  int get balance{
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

class PreminumAccount extends BankAccount implements InterestBearing{
  static const _minBalance=1000;
  static const _interrestRate=0.05;

  PreminumAccount({
     required super._actNumber,
    required super._actName,
    required super._balance
  });
  @override
  void deposit(double amount) {
    if(amount>0){
      updateBalance(_balance+amount);
      print("$amount deposited into Premium Account");
    }else{
      print("Deposit amount should be positive.");
    }
    
  }

  @override
  void withdraw(double amount) {
    if(_balance-amount<_minBalance){
      print("Minium balance of \$$_minBalance should be maintained.");
      return;
    }
    updateBalance(_balance-amount);
    print("Amount of \$$amount withdrawn from Premium Account");
  }
  
  @override
  void calculateInterest() {
    double interestAmt = _balance*_interrestRate;
    updateBalance(_balance+interestAmt);
    print("Interest of \$$interestAmt was added.");
  }

}

class Bank{
  final List<BankAccount> _accounts=[];

  void createBankAccount(BankAccount account){
    _accounts.add(account);
    print("Bank account of Account Number:${_accounts.accountNumber} was created sucessfully.");
  }
}