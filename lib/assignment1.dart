// -------------------------------------
// Abstract Base Class
// -------------------------------------
abstract class BankAccount {
  String _actNumber;
  String _actName;
  double _balance;

  BankAccount({
    required String actNumber,
    required String actName,
    required double balance,
  })  : _actNumber = actNumber,
        _actName = actName,
        _balance = balance;

  // Getters and Setters
  String get accountNumber => _actNumber;
  set accountNumber(String actNumber) => _actNumber = actNumber;

  String get holderName => _actName;
  set holderName(String actName) => _actName = actName;

  double get balance => _balance;
  set balance(double balance) => _balance = balance;

  // Abstract methods
  void withdraw(double amount);
  void deposit(double amount);

  void displayInfo() {
    print("--------------------------");
    print("Account Number: $_actNumber");
    print("Account Holder Name: $_actName");
    print("Balance: \$$_balance");
  }

  void updateBalance(double newAmount) {
    _balance = newAmount;
  }
}

// -------------------------------------
// Interest Interface
// -------------------------------------
abstract class InterestBearing {
  void calculateInterest();
}

// -------------------------------------
// Savings Account
// -------------------------------------
class SavingsAccount extends BankAccount implements InterestBearing {
  static const double _minBalance = 500;
  static const double _interestRate = 0.02;
  int _withdrawalCount = 0;
  static const int _withdrawalLimit = 3;

  SavingsAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      print("\$$amount deposited into Savings Account");
    } else {
      print("Deposit amount should be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (_withdrawalCount >= _withdrawalLimit) {
      print("Withdrawal limit reached for this month.");
      return;
    }
    if (balance - amount < _minBalance) {
      print("Cannot withdraw: Minimum balance of \$$_minBalance must be maintained.");
      return; // ✅ added return to stop withdrawal
    }

    updateBalance(balance - amount);
    _withdrawalCount++;
    print("Amount of \$$amount withdrawn from Savings Account.");
  }

  @override
  void calculateInterest() {
    double interestAmt = balance * _interestRate;
    updateBalance(balance + interestAmt);
    print("Interest of \$$interestAmt was added to Savings Account.");
  }
}

// -------------------------------------
// Checking Account
// -------------------------------------
class CheckingAccount extends BankAccount {
  static const double _overdraftFee = 35;

  CheckingAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      print("\$$amount deposited into Checking Account");
    } else {
      print("Deposit amount should be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (amount <= 0) {
      print("Invalid withdrawal amount.");
      return;
    }

    updateBalance(balance - amount);
    if (balance < 0) {
      updateBalance(balance - _overdraftFee);
      print("\$$_overdraftFee overdraft fee applied.");
    }

    print("Amount of \$$amount withdrawn from Checking Account.");
  }
}

// -------------------------------------
// Premium Account
// -------------------------------------
class PremiumAccount extends BankAccount implements InterestBearing {
  static const double _minBalance = 10000;
  static const double _interestRate = 0.05;

  PremiumAccount({
    required super.actNumber,
    required super.actName,
    required super.balance,
  });

  @override
  void deposit(double amount) {
    if (amount > 0) {
      updateBalance(balance + amount);
      print("\$$amount deposited into Premium Account");
    } else {
      print("Deposit amount should be positive.");
    }
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < _minBalance) {
      print("Minimum balance of \$$_minBalance must be maintained.");
      return;
    }

    updateBalance(balance - amount);
    print("Amount of \$$amount withdrawn from Premium Account.");
  }

  @override
  void calculateInterest() {
    double interestAmt = balance * _interestRate;
    updateBalance(balance + interestAmt);
    print("Interest of \$$interestAmt was added to Premium Account.");
  }
}

// -------------------------------------
// Bank Class
// -------------------------------------
class Bank {
  final List<BankAccount> _accounts = [];

  void createBankAccount(BankAccount account) {
    _accounts.add(account);
    print("Bank account ${account.accountNumber} created successfully.");
  }

  BankAccount? findAccount(String accountNumber) {
    for (var account in _accounts) {
      if (account.accountNumber == accountNumber) {
        return account;
      }
    }
    return null;
  }

  void transfer(String fromAcc, String toAcc, double amount) {
    var from = findAccount(fromAcc);
    var to = findAccount(toAcc);

    if (from == null || to == null) {
      print("One or both accounts not found.");
      return;
    }
    if (from.balance < amount) {
      print("Insufficient balance.");
      return;
    }

    from.withdraw(amount);
    to.deposit(amount);
    print("Amount of \$$amount transferred from $fromAcc to $toAcc.");
  }

  void generateReport() {
    print("\n------- Bank Report --------");
    for (var acc in _accounts) {
      acc.displayInfo();
    }
  }
}

// -------------------------------------
// Main Function
// -------------------------------------
void main() {
  var bank = Bank();

  var savings = SavingsAccount(
      actNumber: "S123", actName: "Ram Dahal", balance: 20000);
  var checking =
      CheckingAccount(actNumber: "C234", actName: "Hari Kunwar", balance: 3000);
  var premium =
      PremiumAccount(actNumber: "P456", actName: "John Peter", balance: 70000);

  bank.createBankAccount(savings);
  bank.createBankAccount(checking);
  bank.createBankAccount(premium);

  savings.deposit(300);
  savings.withdraw(100);
  savings.calculateInterest();

  checking.deposit(400);
  checking.withdraw(200);

  premium.deposit(500);
  premium.withdraw(400);
  premium.calculateInterest();

  bank.transfer("S123", "C234", 500);
  bank.generateReport();
}
