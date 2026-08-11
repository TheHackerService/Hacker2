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

  _title_=(Check if a new day has started and reset withrawal permission
#CheckAndResetDaily

  if(dt.day!= lastCheckDay &dt.day_of_week >1 &dt.day_of_week <=5)
  lastCheckDay= dt.day;
  withdawalAllowedToday= true; reset permission

_title_=(print(New Day detected withdrawal permission reset);
return false;

return false;

_title_=(Close open positions with profit >= ProfitThreshold in XAUUSD
#CloseProfitablePosotions();
  for=int i= PositionsTotal() - 1; i >0; i--);
_ulongticket_= PositionGetTicket(i);
if(PositionWSelectyByTicket(ticket)

  _titile_=(only close positions matching the magic number
long pos_magic= PositionGetInteger(POSITION_MAGIC);
if(int)pos_magic !=MagicNumber)
  continue;

  _double profit_= PositionGetDouble(POSITION_PROFIT);
  _string sym_= PositionGetString(POSITION_SYMBOL);

  _title_=(Ensure we are only handling XAUUSD position (optional extra check)
if(StringCompare(sym, XAUUSD) !=0)
  continue;
if(profit >= ProfitThreshold)
if(trade.PositionClose(ticket)

  _printFormat_=(Failed to close position %d Error code %d, ticket.ResultRetcode);


  _title_=(Simulate or perform withdrawal
#PerformWithdrawal
if(withdrawlAllowedToday)

  _TODO_= implemet real withdrawal logic or API call if required.
_print_=(withdrawal process executed);
withdrawalAllowedToday = false; Disable further withdrawals today

  _title_=(Expert Tick function)
OnTick;
if(!CheckAccountLock);
  Comment=(Account ID missmatch!);
return;

  _title_=(CheclAndResetDaily)
close positions that meet profit threshold
CloseProfitablePosition;

  _title_=(Show current status)
string status= StringFormat=(Day: %d\nWithdrawalAllowed %#", lastCheckDay, withdrawalAllowedToday ?=YES:NO);
Comment(status);
  _title_=(Perform withdrawal (once per day)
if(WithdrawalAllowedToday)

PerformWithdrawal;




  
