double SARVal;


void OnTick()
  {
     string signall = "";
     SARVal = iSAR(_Symbol,_Period,0.02,0.2,0);
     
     if(SARVal < Bid)
         signall = "buy";
         
         
     if(SARVal > Bid)
         signall = "sell";
     
     if(signall == "buy" && OrdersTotal() == 0)
         OrderSend(_Symbol,OP_BUY,0.1,Ask,3,SARVal,0,NULL,0,0,clrBlue);
     modifyBuyStopLost(); 
     
     if(signall == "sell" && OrdersTotal() == 0)
         OrderSend(_Symbol,OP_SELL,0.1,Bid,3,SARVal,0,NULL,0,0,clrRed);
     modifySellyStopLost();
  }
  
void modifyBuyStopLost(){
   for(int i=OrdersTotal();i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS, MODE_TRADES))
         if(OrderType() == OP_BUY)
            if( OrderSymbol() == _Symbol)
               if(OrderStopLoss() < SARVal)
                  OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     SARVal,
                     OrderTakeProfit(),
                     0
                     );
               
     }
}




void modifySellyStopLost(){
   for(int i=OrdersTotal();i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS, MODE_TRADES))
         if(OrderType() == OP_SELL)
            if( OrderSymbol() == _Symbol)
               if(OrderStopLoss() > SARVal)
                  OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     SARVal,
                     OrderTakeProfit(),
                     0
                     );
               
     }


}