import os
import time
import sys
import torch
from TTS.api import TTS

# Configuration
WORKSPACE_DIR = "/data/.openclaw/workspace"
TTS_MODEL_NAME = "tts_models/en/vctk/vits" 
SPEAKER_NAME = "p225" # VCTK p225 is a clear female voice

def main():
    if len(sys.argv) < 2:
        print("Usage: python voice_workflow.py <text_to_speak>")
        return

    text = " ".join(sys.argv[1:])
    timestamp = int(time.time())
    output_filename = f"response_{timestamp}.wav"
    output_path = os.path.join(WORKSPACE_DIR, output_filename)

    print(f"Generating voice for: '{text}'")
    
    try:
        # Check for CUDA
        use_cuda = torch.cuda.is_available()
        device = "cuda" if use_cuda else "cpu"
        
        # Initialize TTS
        tts = TTS(model_name=TTS_MODEL_NAME, progress_bar=False, gpu=use_cuda)
        
        # Generate audio
        tts.tts_to_file(text=text, speaker=SPEAKER_NAME, file_path=output_path)
        
        # Output the filename so the Agent can pick it up
        print(f"OUTPUT_AUDIO:{output_path}")

    except Exception as e:
        print(f"Error generating voice: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
