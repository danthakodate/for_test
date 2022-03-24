//# signature=ZEPETO.IWP#41adb21117e7cbd9bd6696d5b81af32a#0.0.4
// @ts-nocheck
declare module 'ZEPETO.IWP' {

    import * as System from 'System';
    import * as ZEPETO_IWP_Item from 'ZEPETO.IWP.Item';
        
    
    class Item extends System.Object {
        
        public oid: number;
        
        public itemId: string;
        
        public name: string;
        
        public description: string;
        
        public price: number;
        
        public status: string;
        
        public forbiddenReason: ForbiddenReason;
        
        public worldVersionOid: number;
        
        public isPurchased: boolean;
        
        public creatorUid: string;
        
        public iconURL: string;
        
        public get PurchaseType(): ZEPETO_IWP_Item.Type;
        
        public constructor();
        
        public ToString():string;
        
                    
    }
    
    interface ForbiddenReason extends System.Object {
        
                    
    }
    
    class PurchaseFailureReason extends System.Object {
        
        public message: string;
        
        public item: Item;
        
        public constructor();
        
                    
    }
    
}
declare module 'System' {

        
    
    interface Object {
        
                    
    }
    
    interface Int32 extends ValueType {
        
                    
    }
    
    interface ValueType extends Object {
        
                    
    }
    
    interface String extends Object {
        
                    
    }
    
    interface Boolean extends ValueType {
        
                    
    }
    
    interface Enum extends ValueType {
        
                    
    }
    
    interface Array extends Object {
        
                    
    }
    
}
declare module 'ZEPETO.IWP.Item' {

        
    
    enum Type { None = 0, Consumable = 1, NonConsumable = 2 }
    
}

