
int OnInit(){

   return(INIT_SUCCEEDED);
  }

void OnTick(){

   double MA50_1 = iMA(_Symbol,_Period, 50,0,MODE_SMA,PRICE_CLOSE,0);
   double MAEx15_1 = iMA(_Symbol,_Period, 15,0,MODE_EMA,PRICE_CLOSE,0);
   
   double MA50_2 = iMA(_Symbol,_Period, 50,0,MODE_SMA,PRICE_CLOSE,2);
   double MAEx15_2 = iMA(_Symbol,_Period, 15,0,MODE_EMA,PRICE_CLOSE,2);
   
   double MA50_notKnot = iMA(_Symbol,_Period, 50,0,MODE_SMA,PRICE_CLOSE,5);
   double MAEx15_notKnot = iMA(_Symbol,_Period, 15,0,MODE_EMA,PRICE_CLOSE,5);
   
   string signal;
   int currentCandelNum = iBars(_Symbol,_Period);
   if( MathAbs(MAEx15_notKnot - MA50_notKnot) > _Point * 70){
      if((MA50_1 > MAEx15_1) && (MA50_2 < MAEx15_2)){
         signal = "sell";
         ObjectCreate("smallLowArrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[0], High[0]);      
         ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_COLOR,clrPink);       
         ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
         ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_WIDTH,3);
      }
      
      if((MA50_1 < MAEx15_1) && (MA50_2 > MAEx15_2)){
         signal = "buy";
         ObjectCreate("smallLowArrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[0], High[0]);      
         ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_COLOR,clrPink);       
         ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
         ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_WIDTH,3);
      }   
   } 
   
   
   Comment("current signal: ", signal);

}
