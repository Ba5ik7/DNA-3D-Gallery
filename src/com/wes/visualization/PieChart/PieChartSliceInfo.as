package com.wes.visualization.PieChart{
    
    public class PieChartSliceInfo extends Object{
            
            private var _label:String;
            private var _percentage:Number;
            private var _locked:Boolean;
            private var _fillColor:Number;
            private var _fillAlpha:Number;
            private var _borderWidth:Number;
            private var _borderColor:Number;
            private var _borderAlpha:Number;
            public var id:uint;
            
            public function PieChartSliceInfo(default_label:String="Unamed Slice",default_percentage:Number=100,default_locked:Boolean=false){
                label=default_label;
                percentage=default_percentage;
                _locked=default_locked
                //default style
                _fillColor=0xFF0000;
                _fillAlpha=1;
                _borderWidth=1;
                _borderColor=1;
                _borderAlpha=1;
            }
            public function set label(t:String):void{
                _label=t;
            }
            public function get label():String{
                return _label;
            }
            public function set percentage(num:Number):void{
                if(!_locked){
                    if(num>=0 && num <=PieChartInfo.MAX_PERCENTAGE){
                        _percentage=num
                    }else{
                        throw (new Error("A pie slice percentage value can not be greater than "+PieChartInfo.MAX_PERCENTAGE));
                    }
                }else{
                    trace(this+": Slice locked, can't change percentage");
                }
            }
            public function get percentage():Number{
                return _percentage;
            }
            public function lock(){
                _locked=true;
            }
            public function unLock(){
                _locked=false;
            }
            public function get locked():Boolean{
                return _locked;
            }
            public function setLine(ww:Number,cc:Number,aa:Number):void{
                _borderWidth=ww
                _borderColor=cc
                _borderAlpha=aa
            }
            public function setFill(cc:Number,aa:Number):void{
                _fillColor=cc;
                _fillAlpha=aa
            }
            public function getFillColor():Number{
                return _fillColor;
            }
            public function getFillAlpha():Number{
                return _fillAlpha;
            }
            public function getBorderColor():Number{
                return _borderColor;
            }
            public function getBorderAlpha():Number{
                return _borderAlpha;
            }
             public function getBorderWidth():Number{
                return _borderWidth;
            }
            
    }

}