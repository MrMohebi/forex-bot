input double lots = 1;


int currentOrderId;
bool isAllowNewOrderBuy;

void OnTick(){
      
   string signall = "";
   
   double ma20_F = iMA(_Symbol,_Period, 20, 0, MODE_SMA, PRICE_CLOSE, 0);
   double ma50_F = iMA(_Symbol,_Period, 50, 0, MODE_SMA, PRICE_CLOSE, 0);
   double ma100_F = iMA(_Symbol,_Period, 100, 0, MODE_SMA, PRICE_CLOSE, 0);   
   double ma200_F = iMA(_Symbol,_Period, 200, 0, MODE_SMA, PRICE_CLOSE, 0);
   
   
   double stopLost;
   
   if((Ask - ma20_F) < (ma20_F - ma50_F)){
      stopLost = ma50_F;
   }else{
      stopLost = ma20_F;
   }
   
   
   if((ma20_F > ma50_F) && (ma50_F > ma100_F) && (ma100_F > ma200_F)){
      signall = "buy";
        
   }
   
   if((ma20_F < ma50_F) && (ma50_F < ma100_F) && (ma100_F < ma200_F)){
      signall = "sell";
      isAllowNewOrderBuy = true; 
   }
   
   
   if(OrdersTotal() == 0  && signall == "buy" && isAllowNewOrderBuy){
      currentOrderId = OrderSend(_Symbol,OP_BUY,lots,Ask,3,stopLost, 0,NULL,0,0,Green);
      isAllowNewOrderBuy = false;
   }
   modifyBuyStopLost(stopLost);
   

   
   Comment("SGNALL: ", signall); 
    
}


void modifyBuyStopLost(double SL){
   for(int i=OrdersTotal();i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS, MODE_TRADES))
         if(OrderType() == OP_BUY)
            if( OrderSymbol() == _Symbol)
               if(OrderStopLoss() < SL)
                  OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     SL,
                     OrderTakeProfit(),
                     0
                     );
               
     }
}