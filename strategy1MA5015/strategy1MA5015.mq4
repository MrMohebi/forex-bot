input int bigHighLimitDis = 25;
input int smallHighLimitDis = 10;

input int bigLowLimitDis = 25;
input int smallLowLimitDis = 10;

// __init__ for findSmallAndBigHights function
int bigHFinderList[1];
int samllHFinderList[1];
 //-------------------------------------------
 
// __init__ for findSmallAndBigLows function
int bigLFinderList[1];
int samllLFinderList[1];
//------------------------------------------





int OnInit(){

   // __init__ for findSmallAndBigHights function
   bigHFinderList[0] = iBars(_Symbol,_Period);
   samllHFinderList[0] = iBars(_Symbol,_Period);
   //-------------------------------------------
   
   // __init__ for findSmallAndBigLows function
   bigHFinderList[0] = iBars(_Symbol,_Period);
   samllHFinderList[0] = iBars(_Symbol,_Period);
   //------------------------------------------

   return 2;
}


void OnTick(){
   crossMA5015();
   findSmallAndBigLows();
   findSmallAndBigHighs();
}







void crossMA5015(){
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
}






void findSmallAndBigLows(){
   int currentCandelNum = iBars(_Symbol,_Period);

   int smallLCandle = iLowest(_Symbol, _Period, MODE_LOW, smallLowLimitDis, 0);
   int bigLCandle = iLowest(_Symbol, _Period, MODE_LOW, bigLowLimitDis, 0); 
   
   // show a line just to guide base on big Lows
   ObjectDelete("myLine");
   ObjectCreate("myLine",OBJ_HLINE,0,Time[0],High[bigLCandle]);
   
 
   /*
   // find small Low
   if(smallLCandle == (smallLowLimitDis-2) && (currentCandelNum - samllLFinderList[ArrayRange(samllLFinderList,0)-1] >=  smallLowLimitDis) ){
      ArrayResize(samllLFinderList, ArrayRange(samllLFinderList,0)+1);
      samllLFinderList[ArrayRange(samllLFinderList,0)-1] =  currentCandelNum; 
      
      ObjectCreate("smallLowArrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[smallLCandle], High[smallLCandle]);      
      ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_COLOR,clrPink);       
      ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
      ObjectSetInteger(0,"smallLowArrow"+currentCandelNum,OBJPROP_WIDTH,3);          
   }
   */
   
   // find big Lows
   if(bigLCandle == (bigLowLimitDis-2) && (currentCandelNum - bigLFinderList[ArrayRange(bigLFinderList,0)-1] >=  bigLowLimitDis) ){
      ArrayResize(bigLFinderList, ArrayRange(bigLFinderList,0)+1);
      bigLFinderList[ArrayRange(bigLFinderList,0)-1] =  currentCandelNum; 
      
      ObjectCreate("bigLowArrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[bigLCandle], High[bigLCandle]);      
      ObjectSetInteger(0,"bigLowArrow"+currentCandelNum,OBJPROP_COLOR,clrYellow);       
      ObjectSetInteger(0,"bigLowArrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
      ObjectSetInteger(0,"bigLowArrow"+currentCandelNum,OBJPROP_WIDTH,3);          
   }
}







void findSmallAndBigHighs(){
   int currentCandelNum = iBars(_Symbol,_Period);

   int smallHCandle = iHighest(_Symbol, _Period, MODE_HIGH, smallHighLimitDis, 0);
   int bigHCandle = iHighest(_Symbol, _Period, MODE_HIGH, bigHighLimitDis, 0); 
   
   // show a line just to guide base on big hights
   ObjectDelete("myLine");
   ObjectCreate("myLine",OBJ_HLINE,0,Time[0],High[bigHCandle]);
   
 
   /*
   // find small Hightes
   if(smallHCandle == (smallHighLimitDis-2) && (currentCandelNum - samllHFinderList[ArrayRange(samllHFinderList,0)-1] >=  smallHighLimitDis) ){
      ArrayResize(samllHFinderList, ArrayRange(samllHFinderList,0)+1);
      samllHFinderList[ArrayRange(samllHFinderList,0)-1] =  currentCandelNum; 
      
      ObjectCreate("smallArrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[smallHCandle], High[smallHCandle]);      
      ObjectSetInteger(0,"smallArrow"+currentCandelNum,OBJPROP_COLOR,clrRed);       
      ObjectSetInteger(0,"smallArrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
      ObjectSetInteger(0,"smallArrow"+currentCandelNum,OBJPROP_WIDTH,3);          
   }
   */
   
   // find big Hightes
   if(bigHCandle == (bigHighLimitDis-2) && (currentCandelNum - bigHFinderList[ArrayRange(bigHFinderList,0)-1] >=  bigHighLimitDis) ){
      ArrayResize(bigHFinderList, ArrayRange(bigHFinderList,0)+1);
      bigHFinderList[ArrayRange(bigHFinderList,0)-1] =  currentCandelNum; 
      
      ObjectCreate("bigArrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[bigHCandle], High[bigHCandle]);      
      ObjectSetInteger(0,"bigArrow"+currentCandelNum,OBJPROP_COLOR,clrBlue);       
      ObjectSetInteger(0,"bigArrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
      ObjectSetInteger(0,"bigArrow"+currentCandelNum,OBJPROP_WIDTH,3);          
   }
}
