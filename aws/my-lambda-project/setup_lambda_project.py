import os
import subprocess
import sys

def parse_and_create_structure(input_file: str, root_dir: str = '.'):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    current_file = None
    buffer = [] 

    for line in lines:
        if line.strip().startswith('-- FILE:'):
            if current_file and buffer:
                write_file(current_file, buffer, root_dir)
                buffer = []

            current_file = line.strip().split('-- FILE:')[1].strip().rstrip('--').strip()
        else:
            buffer.append(line)

    if current_file and buffer:
        write_file(current_file, buffer, root_dir)

    maybe_setup_venv(root_dir)

def write_file(filepath, content_lines, root_dir):
    full_path = os.path.join(root_dir, filepath)
    os.makedirs(os.path.dirname(full_path), exist_ok=True)

    with open(full_path, 'w', encoding='utf-8') as f:
        f.writelines(content_lines)

    print(f'✅ Created: {full_path}')

def maybe_setup_venv(project_dir):
    req_file = os.path.join(project_dir, 'requirements.txt')
    venv_dir = os.path.join(project_dir, 'venv')

    if not os.path.exists(req_file):
        print('ℹ️ No requirements.txt found — skipping venv setup.')
        return

    # Create venv if it doesn't exist
    if not os.path.exists(venv_dir):
        print('📦 Creating virtual environment...')
        subprocess.run([sys.executable, '-m', 'venv', venv_dir], check=True)
    else:
        print('✅ Virtual environment already exists.')

    pip_path = os.path.join(venv_dir, 'bin', 'pip') if os.name != 'nt' else os.path.join(venv_dir, 'Scripts', 'pip.exe')

    print('📦 Installing dependencies from requirements.txt...')
    subprocess.run([pip_path, 'install', '-r', req_file], check=True)

    print(f'\n✅ Done! To activate your virtual environment, run:')
    print(f'\n  source {venv_dir}/bin/activate' if os.name != 'nt' else f'  {venv_dir}\\Scripts\\activate.bat')

if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Scaffold a project from a multi-file template.')
    parser.add_argument('template_file', help='Path to the template file')
    parser.add_argument('--out', default='lambda_project', help='Output directory name')

    args = parser.parse_args()
    parse_and_create_structure(args.template_file, args.out)

