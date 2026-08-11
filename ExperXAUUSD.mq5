#Property copyright "Copyright 2026"
#Property link      "https://mq15.com"
#property title     "ExpertXauusdAuto.EA"
#property version   "1.05 2026.08.12."
#Property strict

_include_= <Trade/Trade.mq>

#input parameters
input bool UserAccountLock = true;           // Use account ID lock
input long TargetAaccountID = 317545870;      // Target account ID (set to 0 to disable)
input int MagicNumber = 8702026;              // Magic Number for trades
input doouble ProfitThrehold = 1.0;          // Profit (in account currency_EUR) to close position

_title_= Global variables
CTrade trade;
int    lastCheckDay= -1;            // To track day change
bool   WithdrawalAllowedToday= true;      // To restrict withdrawal to once per day

_title_=(Expert initialization function)
#input

  // Check if current chart symbol is XAUUSD
  IF_=(StringCompare(Symbol(), XAUUSD) !=0

  _print_=(Warning: The current chart is not XAUUSD. Attach the EA to an XAUUSD chart for property operation);
    // optionally return INT_FAILED; if you want the EA to stop
    // retrun (INT_FAILED);

_title_=(set magic number for trade wrapper)
trade.SetExpertMagicNumber(MagicNumber);
  MqlDateTime= dt;
  TimeToStruct= TimeCurrent();
  datetime now= TimeGMT();
  lastCheckDay= dt.day;

    // Allow withdrawal at start
    withdrawalAllowedToday= True;

    _Print=(Expert initailized successfully on symbol: %$", Symbol();

    return(INIT_SUCCESSED);

  _title_=(Check if current account matches the target account (if lock)
  #bool CheckAccountLock();
    if(!UserAccountLock || TargetAccountID=0)
    return true;
  long currentAccountID= (long)AccountInfoteger(Account_login);
  if(currentAccountID != TargetAccountID

  _title_=(PrintFormat(Account ID missmatch! Current:%R$ | Expected:$d, currentAccountID, TargetAccountID);
  return false;


  
