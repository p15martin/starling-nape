package
{
	import flash.display.Stage;
	import flash.events.AccelerometerEvent;
	import flash.events.MouseEvent;
	import flash.sensors.Accelerometer;

	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Main extends Sprite
	{
		private static const GRAVITY_X : Number = 0;
		private static const GRAVITY_Y : Number = 3000;

		private static const STEP_TIME : Number = 0.01;

		private static const NUMBER_OF_BALLS : Number = 20;
		private static const BALL_Y : Number = 100;
		private static const BALL_RADIUS : Number = 51.5; // TODO make dynamic
		private static const BALL_ELASTICITY : Number = 1.5;

		[Embed(source="background.png")]
		private var Background:Class;

		private var nativeStage : Stage;
		private var space : Space;
		private var hand : PivotJoint;

		public function Main()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}

		private function init( event : Event ) : void
		{
			nativeStage = Starling.current.nativeStage;

			addBackground();

			createSpace();
			createFloor();
			createHand();

			listenForMouseDown();
			listenForMouseUp();
			listenForEnterFrame();

			useAccelerometer();

			addBalls();
		}

		private function addBackground() : void
		{
			addChild( Image.fromBitmap( new Background() ) );
		}

		private function createSpace():void
		{
			space = new Space( new Vec2( GRAVITY_X, GRAVITY_Y ) );
		}

		private function createFloor():void
		{
			const floor:Body = new Body( BodyType.STATIC );

			// what are all these things?
			floor.shapes.add( new Polygon( Polygon.rect( 0, 768, 1024, 20 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 1024, 0, 200, 768 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( 0, -20, 1024, 20 ) ) );
			floor.shapes.add( new Polygon( Polygon.rect( -200, 0, 200, 768 ) ) );

			floor.space = space;
		}

		private function createHand():void
		{
			hand = new PivotJoint( space.world, null, new Vec2(), new Vec2() );
			hand.active = false;
			hand.stiff = false;
			hand.space = space;
		}

		private function listenForMouseDown():void
		{
			nativeStage.addEventListener( MouseEvent.MOUSE_DOWN, function( event : MouseEvent ) : void
			{
				var mousePoint : Vec2 = new Vec2( event.stageX, event.stageY );
				var bodies : BodyList = space.bodiesUnderPoint( mousePoint );

				if ( bodies.length > 0 )
				{
					var body : Body = bodies.shift();
					hand.body2 = body;
					hand.anchor2 = body.worldToLocal( mousePoint );
					hand.active = true;
				}
			});
		}

		private function listenForMouseUp():void
		{
			nativeStage.addEventListener( MouseEvent.MOUSE_UP, function( event : MouseEvent ) : void
			{
				hand.active = false;
			});
		}

		private function listenForEnterFrame() : void
		{
			addEventListener( Event.ENTER_FRAME, function( event : Event ) : void
			{
				hand.anchor1.setxy( nativeStage.mouseX, nativeStage.mouseY );
				space.step( STEP_TIME );
			});
		}

		private function useAccelerometer():void
		{
			var accelerometer : Accelerometer = new Accelerometer();
			accelerometer.addEventListener( AccelerometerEvent.UPDATE, function( event : AccelerometerEvent ) : void
			{
				space.gravity = new Vec2( -event.accelerationX * 5000, GRAVITY_Y );
			});
		}

		private function addBalls():void
		{
			for ( var i : int = 0; i < NUMBER_OF_BALLS; i++ )
			{
				addBall();
			}
		}

		private function addBall():void
		{
			addChild( createNewBall().graphic );
		}

		private function createNewBall() : Body
		{
			const ball : Body = new Body( BodyType.DYNAMIC, new Vec2( ballRandomX, BALL_Y ) );

			ball.shapes.add( new Circle( BALL_RADIUS, null, new Material( BALL_ELASTICITY ) ) );
			ball.space = space;

			ball.graphic = new Basketball();
			ball.graphicUpdate = updateGraphics;

			return ball;
		}

		private function get ballRandomX() : Number
		{
			return Math.random() * 750 + 50;
		}

		private function updateGraphics( body : Body ) : void
		{
			body.graphic.x = body.position.x;
			body.graphic.y = body.position.y;
			body.graphic.rotation = body.rotation;
		}
	}
}