
string lastPosotion = "sell";

void OnTick(){
   double buyStopLost = (Ask-10000*_Point);
   double sellStopLost = (Bid+10000*_Point);
   
   if(OrdersTotal() == 0 ){
      if(lastPosotion == "buy"){
         OrderSend(_Symbol, OP_SELL, 0.1, Bid,3,sellStopLost ,0);
         lastPosotion = "sell";
      }else{
         if(lastPosotion == "sell"){   
            OrderSend(_Symbol, OP_BUY, 0.1, Ask,3,buyStopLost ,0);
            lastPosotion = "buy";
         }
      }   
         
      
   }
     
     for(int i=0;i<OrdersTotal();i++){
        if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES)){
           if(OrderType() == OP_BUY && OrderSymbol() == Symbol()){ 
               if(OrderStopLoss() <  buyStopLost){
                  OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     buyStopLost,
                     OrderTakeProfit(),
                     0
                  );
               }                         
           }
           
           if(OrderType() == OP_SELL && OrderSymbol() == Symbol()){
               if(OrderStopLoss() >  sellStopLost){
                  OrderModify(
                     OrderTicket(),
                     OrderOpenPrice(),
                     sellStopLost,
                     OrderTakeProfit(),
                     0
                  );
               }   
           }
        }
     }


  }
