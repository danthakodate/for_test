//# signature=ZEPETO.Character.Controller#87320ed872e0d4359859934ca789c1a7#0.0.4
// @ts-nocheck
declare module 'ZEPETO.Character.Controller' {

    import * as UnityEngine from 'UnityEngine';
    import * as System from 'System';
    import * as UnityEngine_Events from 'UnityEngine.Events';
    import * as UnityEngine_InputSystem from 'UnityEngine.InputSystem';
    import * as Zepeto from 'Zepeto';
    import * as ZEPETO_Character_Controller_ZepetoCharacter from 'ZEPETO.Character.Controller.ZepetoCharacter';
    import * as ZepetoInputControl from 'ZepetoInputControl';
    import * as UnityEngine_EventSystems from 'UnityEngine.EventSystems';
        
    
    class ZepetoPlayers extends UnityEngine.MonoBehaviour {
        
        public setting: Setting;
        
        public cameraData: CameraData;
        
        public characterData: CharacterData;
        
        public controllerData: ControllerData;
        
        public floatingUIData: FloatingUIData;
        
        public static OnZepetoPlayersAwake: System.Action;
        
        public static OnZepetoPlayersDestroy: System.Action;
        
        public static isHorizontal: boolean;
        
        public static gravity: number;
        
        public static isInitialized: boolean;
        
        public static onInitialized: System.Action;
        
        public OnAddedLocalPlayer: UnityEngine_Events.UnityEvent;
        
        public OnAddedPlayer: UnityEngine_Events.UnityEvent$1<string>;
        
        public OnRemovedPlayer: UnityEngine_Events.UnityEvent$1<string>;
        
        public static get instance(): ZepetoPlayers;
        
        public get LocalPlayer(): LocalPlayer;
        
        public get ZepetoCamera(): ZepetoCamera;
        
        public constructor();
        
        public CreatePlayer($id: string, $characterInfo: CharacterInfo, $isLocal: boolean, $spawnInfo: SpawnInfo):void;
        
        public CreateCharacter($characterInfo: CharacterInfo, $spawnInfo: SpawnInfo, $complete: System.Action$1<ZepetoCharacter>):void;
        
        public HasPlayer($id: string):boolean;
        
        public GetPlayer($id: string):ZepetoPlayer;
        
        public RemovePlayer($id: string):void;
        
                    
    }
    
    class Setting extends UnityEngine.ScriptableObject {
        
        public isInitialized: boolean;
        
        public camera: UnityEngine.Camera;
        
        public cameraMaxZoomDistance: number;
        
        public cameraMinZoomDistance: number;
        
        public cameraSensitivity: number;
        
        public cameraSpeed: number;
        
        public eyeHeight: number;
        
        public characterJumpPower: number;
        
        public MaxSlopeAngle: number;
        
        public WalkSpeed: number;
        
        public RunSpeed: number;
        
        public layer: UnityEngine.LayerMask;
        
        public shadow: UnityEngine.GameObject;
        
        public animatorController: UnityEngine.RuntimeAnimatorController;
        
        public verticalController: UnityEngine.GameObject;
        
        public horizontalController: UnityEngine.GameObject;
        
        public inputAsset: UnityEngine_InputSystem.InputActionAsset;
        
        public useDefaultVirtualController: boolean;
        
        public eventSystem: UnityEngine.GameObject;
        
        public constructor();
        
                    
    }
    
    class CameraData extends System.Object {
        
        public cameraPrefab: UnityEngine.GameObject;
        
        public maxZoomDistance: number;
        
        public minZoomDistance: number;
        
        public maxPitch: number;
        
        public minPitch: number;
        
        public offset: UnityEngine.Vector3;
        
        public speed: number;
        
        public sensitivity: number;
        
        public layer: UnityEngine.LayerMask;
        
        public constructor();
        
                    
    }
    
    class CharacterData extends System.Object {
        
        public slopeLimit: number;
        
        public stepOffset: number;
        
        public skinWidth: number;
        
        public minMoveDistance: number;
        
        public center: UnityEngine.Vector3;
        
        public radius: number;
        
        public height: number;
        
        public walkSpeed: number;
        
        public runSpeed: number;
        
        public jumpPower: number;
        
        public layer: UnityEngine.LayerMask;
        
        public animatorController: UnityEngine.RuntimeAnimatorController;
        
        public shadow: UnityEngine.GameObject;
        
        public constructor();
        
                    
    }
    
    class ControllerData extends System.Object {
        
        public inputAsset: UnityEngine_InputSystem.InputActionAsset;
        
        public eventSystem: UnityEngine.GameObject;
        
        public useDefaultVirtualController: boolean;
        
        public verticalController: UnityEngine.GameObject;
        
        public horizontalController: UnityEngine.GameObject;
        
        public constructor();
        
                    
    }
    
    class FloatingUIData extends System.Object {
        
        public showNickNameLocalPlayer: boolean;
        
        public showNickNameOtherPlayers: boolean;
        
        public showBubbleChatLocalPlayer: boolean;
        
        public showBubbleChatOtherPlayers: boolean;
        
        public useMiniProfileOnApp: boolean;
        
        public constructor();
        
                    
    }
    
    class LocalPlayer extends UnityEngine.MonoBehaviour {
        
        public get zepetoCamera(): ZepetoCamera;
        
        public get zepetoPlayer(): ZepetoPlayer;
        
        public constructor();
        
        public static Create($player: ZepetoPlayer, $zepetoCamera: ZepetoCamera, $playerControl: ZepetoPlayerControl, $cameraControl: ZepetoCameraControl):LocalPlayer;
        
        public Jump():void;
        
        public Move($dir: UnityEngine.Vector2):void;
        
        public Move($dir: UnityEngine.Vector3):void;
        
        public StopMoving():void;
        
        public RotateCamera($delta: UnityEngine.Vector2):void;
        
        public Zoom($value: number):void;
        
                    
    }
    
    class ZepetoCamera extends UnityEngine.MonoBehaviour {
        
        public additionalSpeed: number;
        
        public additionalSensitivity: number;
        
        public get currentState(): CameraState;
        
        public get currentStateStatus(): StateStatus;
        
        public get position(): UnityEngine.Vector3;
        
        public get rotation(): UnityEngine.Quaternion;
        
        public get distance(): number;
        
        public get camera(): UnityEngine.Camera;
        
        public get cameraParent(): UnityEngine.Transform;
        
        public get isFollow(): boolean;
        
        public get MaxZoomDistance(): number;
        
        public get MinZoomDistance(): number;
        
        public get Speed(): number;
        
        public get Sensitivity(): number;
        
        public constructor();
        
        public static Create($camera: UnityEngine.Camera, $data: CameraData):ZepetoCamera;
        
        public SetFollowTarget($target: UnityEngine.Transform):void;
        
        public Rotate($delta: UnityEngine.Vector2):void;
        
        public DoZoom($delta: number):void;
        
        public SetCameraPosition():void;
        
        public UpdateFollow($deltaTime: number):void;
        
        public Release():void;
        
                    
    }
    
    class CharacterInfo extends System.Object {
        
        public backgroundPic: string;
        
        public character: Zepeto.ZepetoMetadata;
        
        public characterId: string;
        
        public characterPic: string;
        
        public errorMsg: string;
        
        public hashCode: string;
        
        public logInserted: string;
        
        public name: string;
        
        public profilePic: string;
        
        public userId: string;
        
        public zepetoId: string;
        
        public static get Default(): CharacterInfo;
        
        public constructor();
        
                    
    }
    
    class SpawnInfo extends System.ValueType {
        
        public static Default: SpawnInfo;
        
        public position: UnityEngine.Vector3;
        
        public rotation: UnityEngine.Quaternion;
        
        public get_Clone(): SpawnInfo;            
    }
    
    class ZepetoCharacter extends UnityEngine.MonoBehaviour {
        
        public loadedCharacter: System.Action;
        
        public additionalWalkSpeed: number;
        
        public additionalRunSpeed: number;
        
        public additionalJumpPower: number;
        
        public OnChangedState: UnityEngine_Events.UnityEvent$2<CharacterState, CharacterState>;
        
        public get loadingStatus(): ZEPETO_Character_Controller_ZepetoCharacter.LoadingStatus;
        
        public get Context(): Zepeto.ZepetoContext;
        
        public get CurrentState(): CharacterState;
        
        public get CurrentStateStatus(): StateStatus;
        
        public get ZepetoAnimator(): UnityEngine.Animator;
        
        public get characterController(): UnityEngine.CharacterController;
        
        public get WalkSpeed(): number;
        
        public get baseWalkSpeed(): number;
        
        public get RunSpeed(): number;
        
        public get baseRunSpeed(): number;
        
        public get JumpPower(): number;
        
        public get baseJumpPower(): number;
        
        public get tryJump(): boolean;
        
        public get tryMove(): boolean;
        
        public get ElapsedTime(): number;
        
        public constructor();
        
        public GetSocket($socket: KnowSockets):UnityEngine.Transform;
        
        public GetSocket($socket: string):UnityEngine.Transform;
        
        public static Create($hashCode: string, $metadata: Zepeto.ZepetoMetadata, $data: CharacterData, $spawnPoint: SpawnInfo):ZepetoCharacter;
        
        public Move($dir: UnityEngine.Vector2):void;
        
        public Move($dir: UnityEngine.Vector3):void;
        
        public MoveContinuously($dir: UnityEngine.Vector2):void;
        
        public MoveContinuously($dir: UnityEngine.Vector3):void;
        
        public MoveToPosition($pos: UnityEngine.Vector3):void;
        
        public Teleport($pos: UnityEngine.Vector3, $rot: UnityEngine.Quaternion):void;
        
        public StopMoving():void;
        
        public Jump():void;
        
        public Release():void;
        
        public ChangeStateAnimation($state: CharacterState):void;
        
        public SetGesture($gesture: UnityEngine.AnimationClip):void;
        
        public CancelGesture():void;
        
                    
    }
    
    class ZepetoPlayer extends System.Object {
        
        public OnLoadedCharacter: System.Action;
        
        public get isLoadedCharacter(): boolean;
        
        public get id(): string;
        
        public get userId(): string;
        
        public get name(): string;
        
        public get character(): ZepetoCharacter;
        
        public get isLocalPlayer(): boolean;
        
        public constructor($id: string, $info: CharacterInfo, $data: CharacterData, $spawnPoint: SpawnInfo, $isLocal: boolean);
        
        public GetProfileTextureAsync($complete: System.Action$1<UnityEngine.Texture2D>):void;
        
        public Release():void;
        
                    
    }
    
    class ZepetoPlayerControl extends UnityEngine.MonoBehaviour {
        
        public set Enable(value: boolean);
        
        public constructor();
        
        public static Create($playerActions: ZepetoInputControl.PlayerActions):ZepetoPlayerControl;
        
                    
    }
    
    class ZepetoCameraControl extends UnityEngine.MonoBehaviour {
        
        public m_prevDistance: number;
        
        public set Enable(value: boolean);
        
        public constructor();
        
        public static Create($cameraActions: ZepetoInputControl.CameraActions):ZepetoCameraControl;
        
                    
    }
    
    enum CharacterState { Invalid = 0, Idle = 1, Walk = 2, Run = 3, JumpIdle = 4, JumpMove = 5, Teleport = 20, Gesture = 30 }
    
    enum KnowSockets { HEAD_UPPER = 0 }
    
    enum StateStatus { Wait = 0, Enter = 1, Update = 2, End = 3, Leave = 4 }
    
    enum CameraState { Idle = 0, Follow = 1 }
    
    interface ICamera {
        
                    
    }
    
    class FollowCameraState extends State$1<CameraState> {
        
        public constructor($zepetoCamera: ZepetoCamera);
        
                    
    }
    
    interface State$1<TEnum> extends System.Object {
        
                    
    }
    
    class IdleCameraState extends State$1<CameraState> {
        
        public constructor();
        
                    
    }
    
    class Follow2IdleTransition extends Transition$1<CameraState> {
        
        public constructor($zepetoCamera: ZepetoCamera);
        
                    
    }
    
    interface Transition$1<TEnum> extends TransitionBase$1<TEnum> {
        
                    
    }
    
    interface TransitionBase$1<TEnum> extends System.Object {
        
                    
    }
    
    class Idle2FollowTransition extends Transition$1<CameraState> {
        
        public constructor($zepetoCamera: ZepetoCamera);
        
                    
    }
    
    class CharacterShadow extends UnityEngine.MonoBehaviour {
        
        public target: UnityEngine.Transform;
        
        public constructor();
        
                    
    }
    
    class GestureState extends State$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class IdleState extends State$1<CharacterState> {
        
        public constructor($controller: UnityEngine.CharacterController);
        
                    
    }
    
    class JumpIdleState extends State$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class JumpMoveState extends State$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class RunState extends State$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class TeleportState extends State$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class WalkState extends State$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Gesture2IdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class IdleToJumpIdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Idle2RunTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Idle2WalkTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class JumpIdleToIdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class JumpMove2IdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class JumpMove2RunTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class JumpMove2WalkTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Run2IdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Run2JumpMoveTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Run2WalkTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Teleport2IdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Walk2IdleTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Walk2JumpMoveTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Walk2RunTransition extends Transition$1<CharacterState> {
        
        public constructor($character: ZepetoCharacter);
        
                    
    }
    
    class Constant extends System.Object {
        
        public static SETTING_DIRECTORY: string;
        
        public static SETTING_FILE: string;
        
                    
    }
    
    class Utils extends System.Object {
        
        public static GetSettingPath($withExtension?: boolean):string;
        
        public static GetPlayerWithUserId($instance: ZepetoPlayers, $userId: string):ZepetoPlayer;
        
        public static NormalizeByScreenSize($screenPosition: UnityEngine.Vector2):UnityEngine.Vector2;
        
                    
    }
    
    class InputHelper extends System.Object {
        
        public static IsPointerOverUIObjectCurrentPosition():boolean;
        
        public static IsPointerOverUIObject($position: UnityEngine.Vector2):boolean;
        
                    
    }
    
    class EventReceiver extends System.Object {
        
        public static OnCharacterClick: UnityEngine_Events.UnityEvent$2<string, Zepeto.ZepetoContext>;
        
        public static OnCharacterProfileClick: UnityEngine_Events.UnityEvent$2<string, Zepeto.ZepetoContext>;
        
        public static OnClick: UnityEngine_Events.UnityEvent$1<number>;
        
        public constructor();
        
                    
    }
    
    enum EventType { MouseDown = 0 }
    
    class ZepetoCharacterControllerException extends System.Exception {
        
        public constructor($message: string);
        
                    
    }
    
    class StateMachine extends System.Object {
        
        public constructor();
        
                    
    }
    
    class UIZepetoPlayerControl extends UnityEngine.MonoBehaviour {
        
        public constructor();
        
        public StartMoving():void;
        
        public Move($delta: UnityEngine.Vector2):void;
        
        public StopMoving():void;
        
        public Jump():void;
        
        public Update():void;
        
                    
    }
    
    class ZepetoScreenButton extends ZepetoScreenControl {
        
        public OnPointDownEvent: UnityEngine_Events.UnityEvent;
        
        public OnPointUpEvent: UnityEngine_Events.UnityEvent;
        
        public constructor();
        
                    
    }
    
    class ZepetoScreenControl extends UnityEngine.MonoBehaviour {
        
        public OnPointerDown($eventData: UnityEngine_EventSystems.PointerEventData):void;
        
        public OnPointerUp($eventData: UnityEngine_EventSystems.PointerEventData):void;
        
                    
    }
    
    class ZepetoScreenSafeArea extends UnityEngine.MonoBehaviour {
        
        public constructor();
        
                    
    }
    
    class ZepetoScreenStick extends ZepetoScreenControl {
        
        public OnPointerDownEvent: UnityEngine_Events.UnityEvent;
        
        public OnDragEvent: UnityEngine_Events.UnityEvent$1<UnityEngine.Vector2>;
        
        public OnPointerUpEvent: UnityEngine_Events.UnityEvent;
        
        public constructor();
        
        public OnDrag($eventData: UnityEngine_EventSystems.PointerEventData):void;
        
                    
    }
    
    class ZepetoScreenTouchpad extends ZepetoScreenControl {
        
        public OnPointerDownEvent: UnityEngine_Events.UnityEvent;
        
        public OnDragEvent: UnityEngine_Events.UnityEvent$1<UnityEngine.Vector2>;
        
        public OnPointerUpEvent: UnityEngine_Events.UnityEvent;
        
        public canvasGroupTouchPadBackground: UnityEngine.CanvasGroup;
        
        public touchPadBackgroundCurve: UnityEngine.AnimationCurve;
        
        public touchHandle: UnityEngine.RectTransform;
        
        public touchHandleAnimator: UnityEngine.Animator;
        
        public touchHandleOrigin: UnityEngine.RectTransform;
        
        public touchHandleOriginAnimator: UnityEngine.Animator;
        
        public constructor();
        
        public OnDrag($eventData: UnityEngine_EventSystems.PointerEventData):void;
        
                    
    }
    
    interface ZepetoPlayers {
        /** @extension ZEPETO.Character.Controller.Utils */
        GetPlayerWithUserId($userId: string):ZepetoPlayer;
        
                    
    }
    
}
declare module 'UnityEngine' {

    import * as System from 'System';
        
    /**
     * MonoBehaviour is the base class from which every Unity script derives.
     */
    interface MonoBehaviour extends Behaviour {
        
                    
    }
    /**
     * Behaviours are Components that can be enabled or disabled.
     */
    interface Behaviour extends Component {
        
                    
    }
    /**
     * Base class for everything attached to GameObjects.
     */
    interface Component extends Object {
        
                    
    }
    /**
     * Base class for all objects Unity can reference.
     */
    interface Object extends System.Object {
        
                    
    }
    /**
     * A class you can derive from if you want to create objects that don't need to be attached to game objects.
     */
    interface ScriptableObject extends Object {
        
                    
    }
    /**
     * Representation of 2D vectors and points.
     */
    interface Vector2 extends System.ValueType {
        
                    
    }
    /**
     * Representation of 3D vectors and points.
     */
    interface Vector3 extends System.ValueType {
        
                    
    }
    /**
     * Class that represents textures in C# code.
     */
    interface Texture2D extends Texture {
        
                    
    }
    /**
     * Base class for Texture handling.
     */
    interface Texture extends Object {
        
                    
    }
    /**
     * Position, rotation and scale of an object.
     */
    interface Transform extends Component {
        
                    
    }
    /**
     * Interface to control the Mecanim animation system.
     */
    interface Animator extends Behaviour {
        
                    
    }
    /**
     * A CharacterController allows you to easily do movement constrained by collisions without having to deal with a rigidbody.
     */
    interface CharacterController extends Collider {
        
                    
    }
    /**
     * A base class of all colliders.
     */
    interface Collider extends Component {
        
                    
    }
    /**
     * Quaternions are used to represent rotations.
     */
    interface Quaternion extends System.ValueType {
        
                    
    }
    /**
     * Stores keyframe based animations.
     */
    interface AnimationClip extends Motion {
        
                    
    }
    /**
     * Base class for AnimationClips and BlendTrees.
     */
    interface Motion extends Object {
        
                    
    }
    /**
     * A Camera is a device through which the player views the world.
     */
    interface Camera extends Behaviour {
        
                    
    }
    /**
     * Base class for all entities in Unity Scenes.
     */
    interface GameObject extends Object {
        
                    
    }
    /**
     * Specifies Layers to use in a Physics.Raycast.
     */
    interface LayerMask extends System.ValueType {
        
                    
    }
    /**
     * The runtime representation of the AnimatorController. Use this representation to change the Animator Controller during runtime.
     */
    interface RuntimeAnimatorController extends Object {
        
                    
    }
    /**
     * A Canvas placable element that can be used to modify children Alpha, Raycasting, Enabled state.
     */
    interface CanvasGroup extends Behaviour {
        
                    
    }
    /**
     * Store a collection of Keyframes that can be evaluated over time.
     */
    interface AnimationCurve extends System.Object {
        
                    
    }
    /**
     * Position, size, anchor and pivot information for a rectangle.
     */
    interface RectTransform extends Transform {
        
                    
    }
    
}
declare module 'System' {

        
    
    interface Object {
        
                    
    }
    
    type Action = () => void;
    var Action: {new (func: () => void): Action;}
    
    interface Void extends ValueType {
        
                    
    }
    
    interface ValueType extends Object {
        
                    
    }
    
    type MulticastDelegate = (...args:any[]) => any;
    var MulticastDelegate: {new (func: (...args:any[]) => any): MulticastDelegate;}
    
    interface Delegate extends Object {
        
                    
    }
    
    interface Boolean extends ValueType {
        
                    
    }
    
    interface Single extends ValueType {
        
                    
    }
    
    interface String extends Object {
        
                    
    }
    
    type Action$1<T> = (obj: T) => void;
    
    interface Enum extends ValueType {
        
                    
    }
    
    interface Nullable$1<T> extends ValueType {
        
                    
    }
    
    interface Int32 extends ValueType {
        
                    
    }
    
    interface Exception extends Object {
        
                    
    }
    
    interface Array extends Object {
        
                    
    }
    
}
declare module 'UnityEngine.Events' {

    import * as System from 'System';
        
    /**
     * A zero argument persistent callback that can be saved with the Scene.
     */
    interface UnityEvent extends UnityEventBase {
        
                    
    }
    /**
     * Abstract base class for UnityEvents.
     */
    interface UnityEventBase extends System.Object {
        
                    
    }
    /**
     * One argument version of UnityEvent.
     */
    interface UnityEvent$1<T0> extends UnityEventBase {
        
                    
    }
    /**
     * Two argument version of UnityEvent.
     */
    class UnityEvent$2<T0,T1> extends UnityEventBase {
        
        public constructor();
        
        public AddListener($call: UnityAction$2<T0, T1>):void;
        
        public RemoveListener($call: UnityAction$2<T0, T1>):void;
        
        public Invoke($arg0: T0, $arg1: T1):void;
        
                    
    }
    
    type UnityAction$2<T0,T1> = (arg0: T0, arg1: T1) => void;
    
}
declare module 'ZEPETO.Character.Controller.ZepetoCharacter' {

    import * as System from 'System';
        
    
    enum LoadingStatus { NotLoaded = 0, Loading = 1, Loaded = 2, Error = 3 }
    
}
declare module 'Zepeto' {

    import * as UnityEngine from 'UnityEngine';
    import * as System from 'System';
        
    
    interface ZepetoContext extends UnityEngine.MonoBehaviour {
        
                    
    }
    
    interface ZepetoMetadata extends System.Object {
        
                    
    }
    
}
declare module 'RootNamespace' {

    import * as System from 'System';
    import * as UnityEngine_InputSystem from 'UnityEngine.InputSystem';
    import * as System_Collections_Generic from 'System.Collections.Generic';
    import * as UnityEngine_InputSystem_Utilities from 'UnityEngine.InputSystem.Utilities';
    import * as ZepetoInputControl from 'ZepetoInputControl';
        
    
    class ZepetoInputControl extends System.Object {
        
        public get asset(): UnityEngine_InputSystem.InputActionAsset;
        
        public get bindingMask(): System.Nullable$1<UnityEngine_InputSystem.InputBinding>;
        public set bindingMask(value: System.Nullable$1<UnityEngine_InputSystem.InputBinding>);
        
        public get devices(): System.Nullable$1<UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<UnityEngine_InputSystem.InputDevice>>;
        public set devices(value: System.Nullable$1<UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<UnityEngine_InputSystem.InputDevice>>);
        
        public get controlSchemes(): UnityEngine_InputSystem_Utilities.ReadOnlyArray$1<UnityEngine_InputSystem.InputControlScheme>;
        
        public get Player(): ZepetoInputControl.PlayerActions;
        
        public get Camera(): ZepetoInputControl.CameraActions;
        
        public get UI(): ZepetoInputControl.UIActions;
        
        public get KeyboardMouseScheme(): UnityEngine_InputSystem.InputControlScheme;
        
        public get GamepadScheme(): UnityEngine_InputSystem.InputControlScheme;
        
        public get TouchScheme(): UnityEngine_InputSystem.InputControlScheme;
        
        public get JoystickScheme(): UnityEngine_InputSystem.InputControlScheme;
        
        public get XRScheme(): UnityEngine_InputSystem.InputControlScheme;
        
        public constructor();
        
        public Dispose():void;
        
        public Contains($action: UnityEngine_InputSystem.InputAction):boolean;
        
        public GetEnumerator():System_Collections_Generic.IEnumerator$1<UnityEngine_InputSystem.InputAction>;
        
        public Enable():void;
        
        public Disable():void;
        
                    
    }
    
}
declare module 'UnityEngine.InputSystem' {

    import * as UnityEngine from 'UnityEngine';
    import * as System from 'System';
        
    
    interface InputActionAsset extends UnityEngine.ScriptableObject {
        
                    
    }
    
    interface InputBinding extends System.ValueType {
        
                    
    }
    
    interface InputDevice extends InputControl {
        
                    
    }
    
    interface InputControl extends System.Object {
        
                    
    }
    
    interface InputControlScheme extends System.ValueType {
        
                    
    }
    
    interface InputAction extends System.Object {
        
                    
    }
    
    interface InputActionMap extends System.Object {
        
                    
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
    
}
declare module 'ZepetoInputControl' {

    import * as System from 'System';
    import * as UnityEngine_InputSystem from 'UnityEngine.InputSystem';
    import * as UnityEngine_InputSystem_InputAction from 'UnityEngine.InputSystem.InputAction';
        
    
    class PlayerActions extends System.ValueType {
        
        public get Move(): UnityEngine_InputSystem.InputAction;
        
        public get Jump(): UnityEngine_InputSystem.InputAction;
        
        public get enabled(): boolean;
        
        public constructor($wrapper: RootNamespace.ZepetoInputControl);
        
        public Get():UnityEngine_InputSystem.InputActionMap;
        
        public Enable():void;
        
        public Disable():void;
        
        public static op_Implicit($set: PlayerActions):UnityEngine_InputSystem.InputActionMap;
        
        public SetCallbacks($instance: IPlayerActions):void;
        
                    
    }
    
    class CameraActions extends System.ValueType {
        
        public get Scroll(): UnityEngine_InputSystem.InputAction;
        
        public get PrimaryTouchPosition(): UnityEngine_InputSystem.InputAction;
        
        public get PrimaryTouchContact(): UnityEngine_InputSystem.InputAction;
        
        public get SecondaryTouchPosition(): UnityEngine_InputSystem.InputAction;
        
        public get SecondaryTouchContact(): UnityEngine_InputSystem.InputAction;
        
        public get TertiaryTouchPosition(): UnityEngine_InputSystem.InputAction;
        
        public get TertiaryTouchContact(): UnityEngine_InputSystem.InputAction;
        
        public get enabled(): boolean;
        
        public constructor($wrapper: RootNamespace.ZepetoInputControl);
        
        public Get():UnityEngine_InputSystem.InputActionMap;
        
        public Enable():void;
        
        public Disable():void;
        
        public static op_Implicit($set: CameraActions):UnityEngine_InputSystem.InputActionMap;
        
        public SetCallbacks($instance: ICameraActions):void;
        
                    
    }
    
    class UIActions extends System.ValueType {
        
        public get Navigate(): UnityEngine_InputSystem.InputAction;
        
        public get Submit(): UnityEngine_InputSystem.InputAction;
        
        public get Cancel(): UnityEngine_InputSystem.InputAction;
        
        public get Point(): UnityEngine_InputSystem.InputAction;
        
        public get Click(): UnityEngine_InputSystem.InputAction;
        
        public get ScrollWheel(): UnityEngine_InputSystem.InputAction;
        
        public get MiddleClick(): UnityEngine_InputSystem.InputAction;
        
        public get RightClick(): UnityEngine_InputSystem.InputAction;
        
        public get TrackedDevicePosition(): UnityEngine_InputSystem.InputAction;
        
        public get TrackedDeviceOrientation(): UnityEngine_InputSystem.InputAction;
        
        public get enabled(): boolean;
        
        public constructor($wrapper: RootNamespace.ZepetoInputControl);
        
        public Get():UnityEngine_InputSystem.InputActionMap;
        
        public Enable():void;
        
        public Disable():void;
        
        public static op_Implicit($set: UIActions):UnityEngine_InputSystem.InputActionMap;
        
        public SetCallbacks($instance: IUIActions):void;
        
                    
    }
    
    interface IPlayerActions {
        
        OnMove($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnJump($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
                    
    }
    
    interface ICameraActions {
        
        OnScroll($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnPrimaryTouchPosition($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnPrimaryTouchContact($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnSecondaryTouchPosition($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnSecondaryTouchContact($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnTertiaryTouchPosition($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnTertiaryTouchContact($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
                    
    }
    
    interface IUIActions {
        
        OnNavigate($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnSubmit($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnCancel($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnPoint($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnClick($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnScrollWheel($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnMiddleClick($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnRightClick($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnTrackedDevicePosition($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
        OnTrackedDeviceOrientation($context: UnityEngine_InputSystem_InputAction.CallbackContext):void;
        
                    
    }
    
}
declare module 'UnityEngine.EventSystems' {

    import * as System from 'System';
        
    
    interface PointerEventData extends BaseEventData {
        
                    
    }
    
    interface BaseEventData extends AbstractEventData {
        
                    
    }
    
    interface AbstractEventData extends System.Object {
        
                    
    }
    
}
declare module 'ZEPETO.Character.Controller.Events' {

    import * as ZEPETO_Character_Controller from 'ZEPETO.Character.Controller';
        
    
    class GestureEvent extends ZEPETO_Character_Controller.TransitionBase$1<CharacterState> {
        
        public constructor($character: ZEPETO_Character_Controller.ZepetoCharacter);
        
                    
    }
    
    class TeleportEvent extends ZEPETO_Character_Controller.TransitionBase$1<CharacterState> {
        
        public constructor($character: ZEPETO_Character_Controller.ZepetoCharacter);
        
                    
    }
    
}
declare module 'UnityEngine.InputSystem.InputAction' {

    import * as System from 'System';
        
    
    interface CallbackContext extends System.ValueType {
        
                    
    }
    
}

