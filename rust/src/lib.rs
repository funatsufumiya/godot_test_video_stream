use godot::{engine::{IVideoStream, IVideoStreamPlayback, Texture2D, VideoStream, VideoStreamPlayback}, prelude::*};

struct TestVideoExtension {}

#[gdextension]
unsafe impl ExtensionLibrary for TestVideoExtension {}

#[derive(GodotClass)]
#[class(base = VideoStream)]
pub struct TestVideoStream {
    base: Base<VideoStream>,
}

#[godot_api]
impl IVideoStream for TestVideoStream {
    fn init(base: Base<VideoStream>) -> Self {
        godot_print!("TestVideoStream init");

        TestVideoStream { base }
    }

    fn instantiate_playback(&mut self) -> Option<Gd<VideoStreamPlayback>> {
        godot_print!("TestVideoStream instantiate_playback");

        let playback = Gd::<TestVideoStreamPlayback>::default();

        Some(playback.upcast())
    }
}

#[derive(GodotClass)]
#[class(tool, base = VideoStreamPlayback)]
pub struct TestVideoStreamPlayback {
    is_paused: bool,
    is_playing: bool,
    playback_position: f64,
    dummy_length: f64,

    base: Base<VideoStreamPlayback>,
}

impl TestVideoStreamPlayback {
    pub fn new(base: Base<VideoStreamPlayback>) -> Self {
        TestVideoStreamPlayback {
            is_paused: false,
            is_playing: false,
            playback_position: 0.0,
            dummy_length: 120.0,
            base,
        }
    }
}

#[godot_api]
impl IVideoStreamPlayback for TestVideoStreamPlayback {
    fn init(base: Base<VideoStreamPlayback>) -> Self {
        godot_print!("TestVideoStreamPlayback init");

        TestVideoStreamPlayback::new(base)
    }

    fn get_length(&self) -> f64 {
        self.dummy_length
    }

    fn get_playback_position(&self) -> f64 {
        self.playback_position
    }

    fn get_channels(&self) -> i32 {
        0
    }

    fn get_mix_rate(&self) -> i32 {
        0
    }

    fn play(&mut self) {
        self.is_playing = true;
        self.is_paused = false;
    }

    fn stop(&mut self) {
        self.is_playing = false;
        self.is_paused = false;
    }

    fn set_paused(&mut self, paused: bool) {
        self.is_paused = paused;
    }

    fn is_playing(&self) -> bool {
        self.is_playing
    }

    fn is_paused(&self) -> bool {
        self.is_paused
    }

    fn seek(&mut self, time: f64) {
        godot_print!("TestVideoStreamPlayback seek time: {:?}", time);
        self.playback_position = time;
    }

    // fn set_audio_track(&mut self, _track: i32) {
    //     // godot_warn!("TestVideoStreamPlayback set_audio_track does nothing");
    // }

    fn to_string(&self) -> GString {
        "TestVideoStreamPlayback".into()
    }

    fn update(&mut self, delta: f64) {
        // godot_print!("TestVideoStreamPlayback update delta: {:?}", delta);
        godot_print!("TestVideoStreamPlayback update / pos: {:?}",
            self.playback_position
        );
        self.playback_position += delta;
        if self.playback_position >= self.dummy_length {
            self.playback_position = 0.0;
            self.is_playing = false;
            self.is_paused = false;
        }
    }

    fn get_texture(&self) -> Option<Gd<Texture2D>> {
        godot_print!("TestVideoStreamPlayback get_texture");
        None
    }
}