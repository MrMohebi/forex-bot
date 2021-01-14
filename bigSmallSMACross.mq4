input int bigSMA = 50;
input int smallSMA = 20;
input double lots = 1;

int currentOrderId;
string currentOrderType;

void OnTick()
  {
   string signall = "";
   
   double bigSMA1 = iMA(_Symbol,_Period,bigSMA,0,MODE_SMA,PRICE_CLOSE, 1);
   double smallSMA1 = iMA(_Symbol,_Period,smallSMA,0,MODE_SMA,PRICE_CLOSE, 1);
   
   double bigSMA2 = iMA(_Symbol,_Period,bigSMA,0,MODE_SMA,PRICE_CLOSE, 2);
   double smallSMA2 = iMA(_Symbol,_Period,smallSMA,0,MODE_SMA,PRICE_CLOSE, 2);
   
   
   if(bigSMA1 > smallSMA1){
      if(bigSMA2 < smallSMA2){
         signall = "sell";
         if(currentOrderType == "sell")
            OrderClose(currentOrderId,lots,Ask,3,Yellow);
         if(currentOrderType == "buy")
            OrderClose(currentOrderId,lots,Bid,3,Yellow);
            
      }
   }
   
   if(bigSMA1 < smallSMA1){
      if(bigSMA2 > smallSMA2){
         signall = "buy";
         if(currentOrderType == "sell")
            OrderClose(currentOrderId,lots,Ask,3,Yellow);
         if(currentOrderType == "buy")
            OrderClose(currentOrderId,lots,Bid,3,Yellow);
            
      }
   }
      
   
   if(OrdersTotal() == 0  && signall == "buy" && Close[0] > bigSMA1){
     currentOrderId = OrderSend(_Symbol,OP_BUY,lots,Ask,3,0, 0,NULL,0,0,Green);
     currentOrderType = "buy";
   }
   if(OrdersTotal() == 0 && signall == "sell" && Close[0] < bigSMA1){
     currentOrderId =  OrderSend(_Symbol,OP_SELL,lots,Bid,3,0, 0,NULL,0,0,Red);
     currentOrderType = "sell";
   } 
   
   
   Comment("Curent signall: ", signall); 
   Comment("Curent OrderId: ", currentOrderId); 
  }
