//# signature=ZEPETO.World#1ff348855be5d8e7b4a0c74c7f217e9e#0.0.4
// @ts-nocheck
declare module 'ZEPETO.Character.Controller' {

    import * as System from 'System';
    import * as UnityEngine from 'UnityEngine';
    import * as ZEPETO_Character_Controller_CreatePlayerData from 'ZEPETO.Character.Controller.CreatePlayerData';
        
    
    class ZepetoPlayersExtension extends System.Object {
        
        public static CreatePlayer($instance: ZepetoPlayers, $data: CreatePlayerData):void;
        
        public static CreatePlayerWithUserId($instance: ZepetoPlayers, $userId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
        public static CreatePlayerWithZepetoId($instance: ZepetoPlayers, $zepetoId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
        public static CreatePlayerWithHashCode($instance: ZepetoPlayers, $hashCode: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
        public static CreatePlayerWithUserId($instance: ZepetoPlayers, $playerId: string, $userId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
        public static CreatePlayerWithZepetoId($instance: ZepetoPlayers, $playerId: string, $zepetoId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
        public static CreatePlayerWithHashCode($instance: ZepetoPlayers, $playerId: string, $hashCode: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
                    
    }
    
    interface ZepetoPlayers extends UnityEngine.MonoBehaviour {
        
                    
    }
    
    class CreatePlayerData extends System.Object {
        
        public playerId: string;
        
        public type: ZEPETO_Character_Controller_CreatePlayerData.Type;
        
        public value: string;
        
        public spawnInfo: SpawnInfo;
        
        public isLocalPlayer: boolean;
        
        public constructor();
        
                    
    }
    
    interface SpawnInfo extends System.ValueType {
        
                    
    }
    
    class ZepetoCharacterCreator extends System.Object {
        
        public static CreateByZepetoId($zepetoId: string, $spawnInfo: SpawnInfo, $complete: System.Action$1<ZepetoCharacter>):void;
        
        public static CreateByHashCode($hashCode: string, $spawnInfo: SpawnInfo, $complete: System.Action$1<ZepetoCharacter>):void;
        
        public static RemoveCharacter($character: ZepetoCharacter):void;
        
                    
    }
    
    interface ZepetoCharacter extends UnityEngine.MonoBehaviour {
        
                    
    }
    
    class UserInfoExtension extends System.Object {
        
        public static GetProfileTextureAsync($characterInfo: CharacterInfo, $complete: System.Action$1<UnityEngine.Texture2D>):void;
        
                    
    }
    
    interface CharacterInfo extends System.Object {
        
                    
    }
    
    interface ZepetoPlayers {
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayer($data: CreatePlayerData):void;
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayerWithUserId($userId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayerWithZepetoId($zepetoId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayerWithHashCode($hashCode: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayerWithUserId($playerId: string, $userId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayerWithZepetoId($playerId: string, $zepetoId: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        /** @extension ZEPETO.Character.Controller.ZepetoPlayersExtension */
        CreatePlayerWithHashCode($playerId: string, $hashCode: string, $spawnInfo: SpawnInfo, $isLocal: boolean):void;
        
                    
    }
    
    interface CharacterInfo {
        /** @extension ZEPETO.Character.Controller.UserInfoExtension */
        GetProfileTextureAsync($complete: System.Action$1<UnityEngine.Texture2D>):void;
        
                    
    }
    
}
declare module 'System' {

        
    
    interface Object {
        
                    
    }
    
    interface Void extends ValueType {
        
                    
    }
    
    interface ValueType extends Object {
        
                    
    }
    
    interface String extends Object {
        
                    
    }
    
    interface Boolean extends ValueType {
        
                    
    }
    
    type Action$1<T> = (obj: T) => void;
    
    type MulticastDelegate = (...args:any[]) => any;
    var MulticastDelegate: {new (func: (...args:any[]) => any): MulticastDelegate;}
    
    interface Delegate extends Object {
        
                    
    }
    
    interface Enum extends ValueType {
        
                    
    }
    
    interface Array extends Object {
        
                    
    }
    
    interface Int32 extends ValueType {
        
                    
    }
    
    interface Int64 extends ValueType {
        
                    
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
     * Class that represents textures in C# code.
     */
    interface Texture2D extends Texture {
        
                    
    }
    /**
     * Base class for Texture handling.
     */
    interface Texture extends Object {
        
                    
    }
    
}
declare module 'ZEPETO.World' {

    import * as System from 'System';
    import * as ZEPETO_Multiplay from 'ZEPETO.Multiplay';
        
    
    class WorldMultiplayChatContent extends System.Object {
        
        public static instance: WorldMultiplayChatContent;
        
        public OnBeforeSendMessage: System.Action$1<ZEPETO_World_WorldMultiplayChatContent.MessageData>;
        
        public OnReceivedMessage: System.Action$1<IMessage>;
        
        public constructor($multiplay: ZEPETO_Multiplay.ZepetoMultiplayBase);
        
        public Send($text: string):void;
        
        public ReceiveSystemMessage($subject: string, $systemType: SystemMessageType):void;
        
        public ReceiveUserMessage($sessionId: string, $userId: string, $userName: string, $message: string, $messageType: string):void;
        
                    
    }
    
    interface IMessage {
        
                    
    }
    
    enum SystemMessageType { JOIN_USER = 0, LEAVE_USER = 1, JOINED_USERS = 2 }
    
    class WorldMultiplayContent extends System.Object {
        
        public static instance: WorldMultiplayContent;
        
        public constructor($multiplay: ZEPETO_Multiplay.ZepetoMultiplayBase);
        
        public add_onRoomUserList($value: System.Action$1<string[]>):void;
        
        public remove_onRoomUserList($value: System.Action$1<string[]>):void;
        
        public add_onJoinUser($value: System.Action$1<string>):void;
        
        public remove_onJoinUser($value: System.Action$1<string>):void;
        
        public add_onLeaveUser($value: System.Action$1<string>):void;
        
        public remove_onLeaveUser($value: System.Action$1<string>):void;
        
        public GetUserInfos():UserInfo[];
        
        public CheckExistUserInfo($userId: string):boolean;
        
        public GetUserInfo($userId: string):UserInfo;
        
        public GetUserInfoAsSessionId($sessionId: string):UserInfo;
        
        public onRoomUserList;
        
        public onJoinUser;
        
        public onLeaveUser;
        
                    
    }
    
    class UserInfo extends System.Object {
        
        public userId: string;
        
        public hashCode: string;
        
        public name: string;
        
        public profilePic: string;
        
        public followerCount: number;
        
        public followingCount: number;
        
        public creationDate: bigint;
        
        public registered: boolean;
        
        public following: boolean;
        
        public officialAccount: boolean;
        
        public officialAccountType: string;
        
        public userRegistrationDate: bigint;
        
        public zepetoId: string;
        
        public constructor();
        
                    
    }
    
    class ZepetoWorldMultiplay extends ZEPETO_Multiplay.ZepetoDynamicMultiplay {
        
        public constructor();
        
                    
    }
    
    class UserInfoExtension extends System.Object {
        
        public static GetProfileTextureAsync($userInfo: UserInfo, $complete: System.Action$1<UnityEngine.Texture>):void;
        
                    
    }
    
    class Users extends System.Object {
        
        public userOid: string;
        
        public zepetoId: string;
        
        public name: string;
        
        public hashCode: string;
        
        public profilePic: string;
        
        public hasSubsPremium: boolean;
        
        public constructor();
        
                    
    }
    
    class UserIdInfoUsers extends System.Object {
        
        public userOid: string;
        
        public zepetoId: string;
        
        public name: string;
        
        public hashCode: string;
        
        public profilePic: string;
        
        public hasSubsPremium: boolean;
        
        public constructor();
        
                    
    }
    
    class ZepetoWorldHelper extends System.Object {
        
        public static IsTester($version: string, $worldVersionType: string, $worldId: string, $userId: string, $onComplete: System.Action$1<boolean>):void;
        
        public static GetUserInfo($userIds: string[], $onComplete: System.Action$1<Users[]>, $onError: System.Action$1<string>):void;

        /**
         * @deprecated The method should not be used
         */
        public static GetUserIdInfo($userIds: string[], $onComplete: System.Action$1<UserIdInfoUsers[]>, $onError: System.Action$1<string>):void;
        
        public static GetProfileTexture($userId: string, $complete: System.Action$1<UnityEngine.Texture>, $onError: System.Action$1<string>):void;
        
                    
    }
    
    interface UserInfo {
        /** @extension ZEPETO.World.UserInfoExtension */
        GetProfileTextureAsync($complete: System.Action$1<UnityEngine.Texture>):void;
        
                    
    }
    
}
declare module 'ZEPETO.World.WorldMultiplayChatContent' {

    import * as System from 'System';
        
    
    interface MessageData extends System.Object {
        
                    
    }
    
}
declare module 'ZEPETO.Multiplay' {

    import * as UnityEngine from 'UnityEngine';
    import * as System from 'System';
        
    
    interface ZepetoMultiplayBase extends UnityEngine.MonoBehaviour {
        
                    
    }
    
    interface ZepetoDynamicMultiplay extends ZepetoMultiplay$1<DynamicSchema> {
        
                    
    }
    
    interface DynamicSchema extends SchemaBase {
        
                    
    }
    
    interface SchemaBase extends System.Object {
        
                    
    }
    
    interface ZepetoMultiplay$1<T> extends ZepetoMultiplayBase {
        
                    
    }
    
}
declare module 'ZEPETO.Character.Controller.CreatePlayerData' {

        
    
    enum Type { UserId = 0, HashCode = 1, ZepetoId = 2 }
    
}

