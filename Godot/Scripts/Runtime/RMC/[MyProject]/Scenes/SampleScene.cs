using Godot;

namespace RMC.MyProject.Scenes
{
    //  Namespace Properties ------------------------------


    //  Class Attributes ----------------------------------

    /// <summary>
    /// Sample scene controller. Finds child "Cube" and moves it on X/Z
    /// using WASD and arrow keys. Y is unchanged.
    /// </summary>
    public partial class SampleScene : Node3D
    {
        //  Events ----------------------------------------


        //  Properties ------------------------------------

        [Export]
        public float MoveSpeed { get; set; } = 5f;

        [Export]
        public float RotationSpeed { get; set; } = 1f;

        //  Fields ----------------------------------------

        [Export]
        private Node3D _cube;

        //  Godot Methods ---------------------------------

        public override void _Ready()
        {
            GD.Print($"{GetType().Name}.Start()");

            if (_cube == null)
            {
                GD.PushError("SampleScene: Could not find child Node3D named 'Cube'.");
            }
        }

        public override void _Process(double delta)
        {
            float x = 0f;
            float z = 0f;

            // Movement via actions (arrows + WASD mapped above)
            if (Input.IsActionPressed("ui_left")) x -= 1f;
            if (Input.IsActionPressed("ui_right")) x += 1f;
            if (Input.IsActionPressed("ui_up")) z -= 1f;
            if (Input.IsActionPressed("ui_down")) z += 1f;

            var dir = new Vector3(x, 0f, z);

            if (dir.Length() > 1f)
            {
                dir = dir.Normalized();
            }

            _cube.Position += dir * MoveSpeed * (float)delta;

            // Rotate cube
            _cube.RotateY(RotationSpeed * (float)delta);
        }

        //  Event Handlers --------------------------------
    }
}
