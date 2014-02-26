package com.wes.drawing{
    
    import flash.display.MovieClip;
    
    public class DrawingShape extends MovieClip{

        private var _border:uint;
        private var _borderColor:Number;
        private var _borderAlpha:Number;
        private var _fillColor:Number;
        private var _fillAlpha:Number;
        
        public function DrawingShape(){
            // default values
            // general
            setFill(0xFF0000,1)
            setLine(1,0x000000,1)
        }
        
        public function draw(){
            trace("Draw what?")
        }
        
        public function setFill(fc:Number,fa:Number){
            _fillColor=fc;
            _fillAlpha=fa
        }
        public function setLine(b:uint,bc:Number,ba:Number){
            _border=b;
            _borderColor=bc;
            _borderAlpha=ba;
        }
        
        public function get border():uint{
            return _border
        }
        public function get borderColor():Number{
            return _borderColor
        }
        public function get borderAlpha():Number{
            return _borderAlpha
        }
        public function get fillColor():Number{
            return _fillColor
        }
        public function get fillAlpha():Number{
            return _fillAlpha
        }
        
    }
    
}