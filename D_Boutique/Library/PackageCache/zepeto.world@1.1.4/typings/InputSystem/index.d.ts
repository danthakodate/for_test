//# signature=Unity.InputSystem#23e3e2289927a75b753ef2e608c2a4f3#0.0.4
// @ts-nocheck
declare module 'UnityEngine.InputSystem' {

    import * as UnityEngine from 'UnityEngine';
    import * as System from 'System';
    import * as System_Collections_Generic from 'System.Collections.Generic';
    import * as UnityEngine_InputSystem_Utilities from 'UnityEngine.InputSystem.Utilities';
        
    
    class InputActionAsset extends UnityEngine.ScriptableObject {
        
        public static Extension: string;
        
        public get enabled(): boolean;
        
        public get actionMaps(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputActionMap>;
        
        public get controlSchemes(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputControlScheme>;
        
        public get bindingMask(): System.Nullable$1<InputBinding>;
        public set bindingMask(value: System.Nullable$1<InputBinding>);
        
        public get devices(): System.Nullable$1<UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputDevice>>;
        public set devices(value: System.Nullable$1<UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputDevice>>);
        
        public constructor();
        
        public get_Item($actionNameOrId: string):InputAction;
        
        public ToJson():string;
        
        public LoadFromJson($json: string):void;
        
        public static FromJson($json: string):InputActionAsset;
        
        public FindAction($actionNameOrId: string, $throwIfNotFound?: boolean):InputAction;
        
        public FindActionMap($nameOrId: string, $throwIfNotFound?: boolean):InputActionMap;
        
        public FindActionMap($id: System.Guid):InputActionMap;
        
        public FindAction($guid: System.Guid):InputAction;
        
        public FindControlSchemeIndex($name: string):number;
        
        public FindControlScheme($name: string):System.Nullable$1<InputControlScheme>;
        
        public Enable():void;
        
        public Disable():void;
        
        public Contains($action: InputAction):boolean;
        
        public GetEnumerator():System_Collections_Generic.IEnumerator$1<InputAction>;
        
                    
    }
    
    class InputActionMap extends System.Object {
        
        public get name(): string;
        
        public get asset(): InputActionAsset;
        
        public get id(): System.Guid;
        
        public get enabled(): boolean;
        
        public get actions(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputAction>;
        
        public get bindings(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputBinding>;
        
        public get controlSchemes(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputControlScheme>;
        
        public get bindingMask(): System.Nullable$1<InputBinding>;
        public set bindingMask(value: System.Nullable$1<InputBinding>);
        
        public get devices(): System.Nullable$1<UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputDevice>>;
        public set devices(value: System.Nullable$1<UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputDevice>>);
        
        public constructor();
        
        public constructor($name: string);
        
        public get_Item($actionNameOrId: string):InputAction;
        
        public add_actionTriggered($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public remove_actionTriggered($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public Dispose():void;
        
        public FindAction($nameOrId: string, $throwIfNotFound?: boolean):InputAction;
        
        public FindAction($id: System.Guid):InputAction;
        
        public IsUsableWithDevice($device: InputDevice):boolean;
        
        public Enable():void;
        
        public Disable():void;
        
        public Clone():InputActionMap;
        
        public Contains($action: InputAction):boolean;
        
        public ToString():string;
        
        public GetEnumerator():System_Collections_Generic.IEnumerator$1<InputAction>;
        
        public static FromJson($json: string):InputActionMap[];
        
        public static ToJson($maps: System_Collections_Generic.IEnumerable$1<InputActionMap>):string;
        
        public ToJson():string;
        
        public OnBeforeSerialize():void;
        
        public OnAfterDeserialize():void;
        
        public actionTriggered;
        
                    
    }
    
    interface InputControlScheme extends System.ValueType {
        
                    
    }
    
    interface InputBinding extends System.ValueType {
        
                    
    }
    
    interface InputDevice extends InputControl {
        
                    
    }
    
    interface InputControl extends System.Object {
        
                    
    }
    
    class InputAction extends System.Object {
        
        public get name(): string;
        
        public get type(): InputActionType;
        
        public get id(): System.Guid;
        
        public get expectedControlType(): string;
        public set expectedControlType(value: string);
        
        public get processors(): string;
        
        public get interactions(): string;
        
        public get actionMap(): InputActionMap;
        
        public get bindingMask(): System.Nullable$1<InputBinding>;
        public set bindingMask(value: System.Nullable$1<InputBinding>);
        
        public get bindings(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputBinding>;
        
        public get controls(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<InputControl>;
        
        public get phase(): InputActionPhase;
        
        public get enabled(): boolean;
        
        public get triggered(): boolean;
        
        public get activeControl(): InputControl;
        
        public constructor();
        
        public constructor($name?: string, $type?: InputActionType, $binding?: string, $interactions?: string, $processors?: string, $expectedControlType?: string);
        
        public add_started($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public remove_started($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public add_canceled($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public remove_canceled($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public add_performed($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public remove_performed($value: System.Action$1<UnityEngine_InputSystem_InputAction.CallbackContext>):void;
        
        public Dispose():void;
        
        public ToString():string;
        
        public Enable():void;
        
        public Disable():void;
        
        public Clone():InputAction;
        
        public ReadValue<TValue>():TValue;
        
        public ReadValueAsObject():any;
        
        public started;
        
        public canceled;
        
        public performed;
        
                    
    }
    
    enum InputActionType { Value = 0, Button = 1, PassThrough = 2 }
    
    enum InputActionPhase { Disabled = 0, Waiting = 1, Started = 2, Performed = 3, Canceled = 4 }
    
}
declare module 'UnityEngine' {

    import * as System from 'System';
        
    /**
     * A class you can derive from if you want to create objects that don't need to be attached to game objects.
     */
    interface ScriptableObject extends Object {
        
                    
    }
    /**
     * Base class for all objects Unity can reference.
     */
    interface Object extends System.Object {
        
                    
    }
    
}
declare module 'System' {

        
    
    interface Object {
        
                    
    }
    
    interface String extends Object {
        
                    
    }
    
    interface Boolean extends ValueType {
        
                    
    }
    
    interface ValueType extends Object {
        
                    
    }
    
    interface Nullable$1<T> extends ValueType {
        
                    
    }
    
    interface Void extends ValueType {
        
                    
    }
    
    interface Guid extends ValueType {
        
                    
    }
    
    interface Int32 extends ValueType {
        
                    
    }
    
    interface Enum extends ValueType {
        
                    
    }
    
    type Action$1<T> = (obj: T) => void;
    
    type MulticastDelegate = (...args:any[]) => any;
    var MulticastDelegate: {new (func: (...args:any[]) => any): MulticastDelegate;}
    
    interface Delegate extends Object {
        
                    
    }
    
    interface Array extends Object {
        
                    
    }
    
}
declare module 'UnityEngine.InputSystem.Utilities' {

    import * as System from 'System';
        
    
    interface ReadOnlyArray$1<TValue> extends System.ValueType {
        
                    
    }
    
}
declare module 'System.Collections.Generic' {

        
    
    interface IEnumerator$1<T> {
        
                    
    }
    
    interface IEnumerable$1<T> {
        
                    
    }
    
}
declare module 'UnityEngine.InputSystem.InputAction' {

    import * as System from 'System';
        
    
    interface CallbackContext extends System.ValueType {
        
                    
    }
    
}

