int bigHLimitDis = 15;
int smallHLimitDis = 10;


int bigHFinderList[1];
int samllHFinderList[1];


int bigArrowCounter = 0;
int smallArrowCounter = 0;

void OnInit(){
   bigHFinderList[0] = iBars(_Symbol,_Period);
   samllHFinderList[0] = iBars(_Symbol,_Period);
}


void OnTick(){
   int currentCandelNum = iBars(_Symbol,_Period);

   int smallHCandle = iHighest(_Symbol, _Period, MODE_HIGH, smallHLimitDis, 0);
   int bigHCandle = iHighest(_Symbol, _Period, MODE_HIGH, bigHLimitDis, 0); 
   
   ObjectDelete("myLine");
   ObjectCreate("myLine",OBJ_HLINE,0,Time[0],High[smallHCandle]);
   Comment(
      "last Find Bar: ", IntegerToString(samllHFinderList[ArrayRange(samllHFinderList,0)-1]) ,"/n"
      "array size: ", IntegerToString(ArrayRange(samllHFinderList,0)) , "/n"
   );
   
   // find small Hightes
   if((samllHFinderList[ArrayRange(samllHFinderList,0)-1] + smallHLimitDis) < (currentCandelNum - smallHCandle)){
      ArrayResize(samllHFinderList, ArrayRange(samllHFinderList,0)+1);
      samllHFinderList[ArrayRange(samllHFinderList,0)-1] =  currentCandelNum; 
      
      ObjectCreate("arrow"+currentCandelNum,OBJ_ARROW_DOWN,0,Time[currentCandelNum - samllHFinderList[ArrayRange(samllHFinderList,0)-1] - 1],High[currentCandelNum - samllHFinderList[ArrayRange(samllHFinderList,0)-1] - 1],Time[currentCandelNum - samllHFinderList[ArrayRange(samllHFinderList,0)-1] + 1],High[currentCandelNum - samllHFinderList[ArrayRange(samllHFinderList,0)-1] + 1]);      
      ObjectSetInteger(0,"arrow"+currentCandelNum,OBJPROP_COLOR,clrRed);       
      ObjectSetInteger(0,"arrow"+currentCandelNum,OBJPROP_STYLE,STYLE_SOLID);       
      ObjectSetInteger(0,"arrow"+currentCandelNum,OBJPROP_WIDTH,3);          
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   /*
   
   // find small Hightes
   if(iBars(_Symbol,_Period) - smallHLimitDis > samllHFinderList[ArrayRange(samllHFinderList,0)-1]){
      if(){
      
      
      }
   }
   
   
   
   
   
   if(Close[hCandle+1] < Close[hCandle] && Close[hCandle+2] < Close[hCandle] && Close[hCandle+3] < Close[hCandle]){
      
      Comment("array range is:", ArrayRange(drowArrowCArr,0),"\n",      
      "current HH:", hCandle,"\n",
      "last HH:", drowArrowCArr[ArrayRange(drowArrowCArr,0)-1],"\n",
      "bars: ", iBars(_Symbol,_Period),"\n",
      "last HBar: " , drowArrowCArr[ArrayRange(drowArrowCArr,0)-1]
      
      );
      
      if(iBars(_Symbol,_Period) > drowArrowCArr[ArrayRange(drowArrowCArr,0)-1] + 7){      
         ArrayResize(drowArrowCArr, ArrayRange(drowArrowCArr,0)+1);
         drowArrowCArr[ArrayRange(drowArrowCArr,0)-1] =  iBars(_Symbol,_Period);         
         ObjectCreate("arrow"+arrowCounter,OBJ_ARROW_DOWN,0,Time[hCandle],High[hCandle]);      
         ObjectSetInteger(0,"arrow"+arrowCounter,OBJPROP_COLOR,clrRed);       
         ObjectSetInteger(0,"arrow"+arrowCounter,OBJPROP_STYLE,STYLE_SOLID);       
         ObjectSetInteger(0,"arrow"+arrowCounter,OBJPROP_WIDTH,3);      
         arrowCounter++;
      }

   }
   
   
   */

}

/*
datetime ArrayTime[], LastTime;
bool NewBar(int period) {
    bool firstRun = false, newBar = false;

    ArraySetAsSeries(ArrayTime,true);
    CopyTime(Symbol(),period,0,2,ArrayTime);

    if(LastTime == 0) firstRun = true;
    if(ArrayTime[0] > LastTime) {
        if(firstRun == false) newBar = true;
        LastTime = ArrayTime[0];
    }
    return newBar;   
}

*/