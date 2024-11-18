using System;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using Microsoft.Win32;

namespace PBOTool
{
    public partial class MainWindow : Window
    {
        private ObservableCollection<string> folderPaths;

        public MainWindow()
        {
            InitializeComponent();
            folderPaths = new ObservableCollection<string>();
            FolderListView.ItemsSource = folderPaths;
            LoadSavedPath();
        }

        // PBO Manager 경로 로드
        private void LoadSavedPath()
        {
            string savedPath = Properties.Settings.Default.PboPath;

            if (!string.IsNullOrEmpty(savedPath) && File.Exists(savedPath))
            {
                PBOPath.Text = savedPath;
            }
            else if (Directory.Exists(@"C:\Program Files\PBO Manager v.1.4 beta\"))
            {
                PBOPath.Text = @"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe";
                SavePboPath(PBOPath.Text);
            }
        }

        // PBO 경로 저장
        private void SavePboPath(string path)
        {
            Properties.Settings.Default.PboPath = path;
            Properties.Settings.Default.Save();
        }

        // 폴더의 마지막 이름 가져오기
        private string GetLastFolderName(string path) => Path.GetFileName(path.TrimEnd(Path.DirectorySeparatorChar));

        // PBO 파일 언팩
        private void UnPacking(string pboFilePath)
        {
            string outputFolder = $"{Path.GetDirectoryName(pboFilePath)}\\{Path.GetFileNameWithoutExtension(pboFilePath)}";
            RunProcess(@"-unpack", pboFilePath, outputFolder);
        }

        // 폴더를 PBO 파일로 패킹
        private void Packing(string folder)
        {
            string outputPbo = $"{Directory.GetParent(folder)}\\{GetLastFolderName(folder)}.pbo";
            RunProcess(@"-pack", folder, outputPbo);
        }

        // PBO Manager 실행
        private void RunProcess(string command, string inputPath, string outputPath)
        {
            string exePath = PBOPath.Text;
            if (string.IsNullOrEmpty(exePath) || !File.Exists(exePath))
            {
                MessageBox.Show("PBO Manager 경로를 설정하세요.", "오류", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            ProcessStartInfo processInfo = new ProcessStartInfo
            {
                FileName = exePath,
                Arguments = $"{command} \"{inputPath}\" \"{outputPath}\"",
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            try
            {
                using (Process process = Process.Start(processInfo))
                {
                    string output = process.StandardOutput.ReadToEnd();
                    string error = process.StandardError.ReadToEnd();
                    process.WaitForExit();

                    if (!string.IsNullOrEmpty(error))
                        MessageBox.Show($"오류: {error}", "실패", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"프로세스 실행 오류: {ex.Message}", "실패", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        // 드래그 앤 드롭 기능
        private void FolderListView_Drop(object sender, DragEventArgs e)
        {
            if (e.Data.GetDataPresent(DataFormats.FileDrop))
            {
                string[] files = (string[])e.Data.GetData(DataFormats.FileDrop);
                foreach (string path in files)
                {
                    if (Directory.Exists(path) || (File.Exists(path) && Path.GetExtension(path).Equals(".pbo", StringComparison.OrdinalIgnoreCase)))
                    {
                        if (!folderPaths.Contains(path))
                        {
                            folderPaths.Add(path);
                        }
                    }
                }
            }
        }

        private void FolderListView_DragEnter(object sender, DragEventArgs e)
        {
            e.Effects = e.Data.GetDataPresent(DataFormats.FileDrop) ? DragDropEffects.Copy : DragDropEffects.None;
        }

        // 경로 찾기 버튼
        private void Button_FindPboPath_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog
            {
                Title = "PBO Manager 파일 찾기",
                Filter = "PBOConsole 실행 파일|PBOConsole.exe",
                InitialDirectory = @"C:\Program Files\PBO Manager v.1.4 beta",
                CheckFileExists = true,
                CheckPathExists = true
            };

            if (openFileDialog.ShowDialog() == true)
            {
                PBOPath.Text = openFileDialog.FileName;
                SavePboPath(PBOPath.Text);
            }
        }

        // 패킹 버튼 클릭
        private void Button_Pack_Click(object sender, RoutedEventArgs e)
        {
            if (folderPaths.Count == 0)
            {
                MessageBox.Show("목록에 파일이 없습니다.", "오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (MessageBox.Show("폴더를 PBO 파일로 생성할까요?", "확인", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                foreach (string path in folderPaths)
                {
                    if (Directory.Exists(path))
                        Packing(path);
                }
            }
        }

        // 언팩 버튼 클릭
        private void Button_Unpack_Click(object sender, RoutedEventArgs e)
        {
            if (folderPaths.Count == 0)
            {
                MessageBox.Show("목록에 파일이 없습니다.", "오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (MessageBox.Show("PBO 파일을 언팩할까요?", "확인", MessageBoxButton.OKCancel) == MessageBoxResult.OK)
            {
                foreach (string path in folderPaths)
                {
                    if (File.Exists(path) && Path.GetExtension(path).Equals(".pbo", StringComparison.OrdinalIgnoreCase))
                        UnPacking(path);
                }
            }
        }

        // 목록 지우기 버튼
        private void Button_Clear_Click(object sender, RoutedEventArgs e)
        {
            folderPaths.Clear();
        }
    }
}
