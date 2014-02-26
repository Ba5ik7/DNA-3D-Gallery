package com.wes.visualization.PieChart{
    
    import flash.events.Event;
    import flash.events.EventDispatcher

    
    public class PieChartInfo extends EventDispatcher{
        
        private var _slices:Array;
        private var _name:String;
        private var _uid_index:uint;
        public static var INFO_UPDATED:String="INFO_UPDATED";
        public static var MAX_PERCENTAGE:int=100; // num
        public static var MAX_ANGLE:int=360;
        
        public function PieChartInfo(){
            _name="Unamed Pie Chart";
            _slices=new Array();
            _uid_index=0;
        }
        public function get slices():Array{
            return _slices;
        }
        /*
        addSlice
            Adds a slice to the PieChartInfo object and returns it's unique id
            Checks that the PieChartInfo has a unique label, otherwise modifies the name
        */
        public function addSlice(_slice:PieChartSliceInfo):uint{
            if( checkSliceName(_slice.label)){
                _slices.push(_slice);
                _uid_index++;
                _slice.id=_uid_index;
                return _uid_index;
            }
            
			
            _slice.label=_slice.label+"+";
            addSlice(_slice);
			
			
            
            return 0;
            
        }
         /*
        checkSliceName
            checks a label to be unique returns false if not
        */
        private function checkSliceName(s:String):Boolean{
            for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].label==s){
                    return false;
                }
            }
            return true;
        }
        /*
        getSliceById
            return a slice with a given id
        */
        public function getSliceById(_id:uint):PieChartSliceInfo{
            for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].id==_id){
                    return _slices[i];
                }
            }
            throw(new Error("Slice id "+_id+" not found"))
        }
        /*
        getSliceByLabel
            return a slice with a given label
        */
        public function getSliceByLabel(_label:String):PieChartSliceInfo{
         for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].label==_label){
                    return _slices[i];
                }
            }
            throw(new Error("Slice label "+_label+" not found"))
        }
        /*
        removeSliceById
            removes a slice from the PieChartInfo object with a given id
        */
        public function removeSliceById(_id:uint):void{
         for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].id==_id){
                    _slices[i]=null;
                    _slices.splice(i,1);
                    i=_slices.length;
                }
            }
        
        } 
        /*
        removeSliceByLabel
            removes a slice from the PieChartInfo object with a given label
        */
        public function removeSliceByLabel(_label:String):void{
            for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].label==_label){
                    _slices[i]=null;
                    _slices.splice(i,1);
                    i=_slices.length;
                }
            }
        }
         /*
        setSlicePercentageById
            set the percentahe of a PieChartSliceInfo object with a given id
        */
        public function setSlicePercentageById(_id:uint,_perc:Number):void{
            for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].id==_id){
                    _slices[i].percentage=_perc;
                    i=_slices.length;
                }
            }
        }
        /*
        setSlicePercentageByLabel
            set the percentahe of a PieChartSliceInfo object with a given label
        */
        public function setSlicePercentageByLabel(_label:String,_perc:Number):void{
             for(var i:int=0;i<_slices.length;i++){
                if(_slices[i].label==_label){
                    _slices[i].percentage=_perc;
                    i=_slices.length;
                }
            }
        
        }
        
         /*
        remainingPercentage
            gets the remaining percentage missing to complete MAX_PERCENTAGE (100)
        */
        
        public function get remainingPercentage():Number{
            var i:int;
            var sum:Number=0;
            for(i=0;i<_slices.length;i++){
                sum+=_slices[i].percentage
            } 
                return MAX_PERCENTAGE-sum;
        }
        /*
        validateSlicesSum
            attemps to balance the PieChart so that their percentage sum is 100
            returns error if all slices are locked
            dispatched INFO_UPDATED event
        */
        
        public function validateSlicesSum():void{
            //check all slices for locked, get sum in the process
            var allLocked:Boolean=true
            var numLocked:int=0;
            var sum:Number=0;
            var compensate:Number=0;
            var i:int;
             for(i=0;i<_slices.length;i++){
                if(!_slices[i].locked){
                    allLocked=false
                }else{
                    numLocked++
                }
                 sum+=_slices[i].percentage
             }
             if(sum!=MAX_PERCENTAGE){
                if(allLocked){
                    throw(new Error("The sum of the slices is not "+MAX_PERCENTAGE+" and all Pie Chart slices are locked."))
                }
                compensate=(Math.abs(sum-MAX_PERCENTAGE))/(slices.length-numLocked)
                if(sum>100){
                    for(i=0;i<_slices.length;i++){
                        if(!_slices[i].locked){
                            _slices[i].percentage-=compensate
                        }
                    }
                }
                if(sum<MAX_PERCENTAGE){
                    for(i=0;i<_slices.length;i++){
                        if(!_slices[i].locked){
                            _slices[i].percentage+=compensate
                        }
                    }
                }
             }
            
        }
        
        
    }
}