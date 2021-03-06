(icomplete-mode 1)
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/auto-install")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(setq debug-on-error t)
;;ビープ音を消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;(global-set-key "\C-z" nil)

;; 日本語の設定（UTF-8）
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
;;(prefer-coding-system 'utf-8)

; ことえりで日本語
(setq default-input-method "MacOSX")

;;;; 種々雑多な設定
;; Official Emacs 用の設定（inline_patch をあててあります）
; (setq default-input-method "MacOSX")

;; 全角記号類「！”＃＄％＆’（）＝〜｜｀『＋＊』＜＞？＿」を入力できるようにする（Mac Emacs では不要）
; (mac-add-key-passed-to-system 'shift)

;; 編集行のハイライト
(global-hl-line-mode)

;; ウインドウ分割時に画面外へ出る文章を折り返す
(setq truncate-partial-width-windows nil)

;; バックアップファイルを作らないようにする
(setq make-backup-files nil)

;; 括弧の対応関係をハイライト表示
(show-paren-mode nil)

;; ツールバーを表示しないようにする（Official Emacs の場合は 0）
; (tool-bar-mode 0)

;; スタートアップ画面を表示しないようにする
(setq inhibit-startup-message t)

;; 行間隔を少し広げる
(set-default 'line-spacing 4)

;; ウィンドウ（フレーム）のサイズ設定する
 (setq default-frame-alist
'((width . 200) (height . 60) (top . 0)(left . 0)))

;; 背景を透過させる
(add-to-list 'default-frame-alist '(alpha . (85 60)))
(set-frame-parameter nil 'alpha '(85 60))

;; マウス・スクロールを滑らかにする（Mac Emacs 専用）
;;(setq mac-mouse-wheel-smooth-scroll t)
(mouse-wheel-mode)
(global-set-key [wheel-up]
                '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [wheel-down]
                '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [double-wheel-up]
                '(lambda () "" (interactive) (scroll-down 1)))
(global-set-key [double-wheel-down]
                '(lambda () "" (interactive) (scroll-up 1)))
(global-set-key [triple-wheel-up]
                '(lambda () "" (interactive) (scroll-down 2)))
(global-set-key [triple-wheel-down]
                '(lambda () "" (interactive) (scroll-up 2)))

;;改行時にインデント
;;(global-set-key "\C-m" 'newline-and-indent)

(add-hook 'c-mode-common-hook
          '(lambda ()
             (local-set-key "\C-m" 'reindent-then-newline-and-indent)))

;; タブ幅
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; 行末の空白を強調表示
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "#b14770")

;; カーソルの色を設定
; (set-cursor-color "DarkGray")

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;; ツールバー非表示
(tool-bar-mode -1)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; yes or noをy or n
(fset 'yes-or-no-p 'y-or-n-p)

;;ペースト時に選択範囲を置き換える
(delete-selection-mode 1)

;; キーの設定（ある程度 Mac 標準に準拠させる）
(setq mac-command-key-is-meta nil)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(global-set-key [?\s-c] 'kill-ring-save)
(global-set-key [?\s-v] 'yank)
(global-set-key [?\s-x] 'kill-region)
(global-set-key [?\s-z] 'undo)
(global-set-key [?\s-s] 'save-buffer)
(global-set-key [?\s-q] 'save-buffers-kill-terminal)
(global-set-key [?\s-f] 'isearch-forward)
(global-set-key [?\s-g] 'isearch-repeat-forward)
;;(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-h" 'help)

;; Undo limit
(setq undo-limit 100000)
(setq undo-strong-limit 130000)

;; フォントの設定
;; 出典：http://sakito.jp/emacs/emacs23.html
(create-fontset-from-ascii-font "Menlo-12:weight=normal:slant=normal" nil "menlokakugo")
(set-fontset-font "fontset-menlokakugo"
	'unicode
	(font-spec :family "Hiragino Kaku Gothic ProN" :size 14)
	nil
	'append)
(add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))

;; 行番号の設定（F5 キーで表示・非表示を切り替え）
;; 出典：調査中
(require 'linum)
(global-linum-mode 0)
(global-set-key [f5] 'linum-mode)
(setq linum-format
	(lambda (line) (propertize (format
		(let ((w (length (number-to-string
			(count-lines (point-min) (point-max))
		)))) (concat "%" (number-to-string w) "d "))
	line) 'face 'linum)))
(setq linum-format "%5d ")

;;===========================
;;Aspell
;;===========================
;; スペルチェッカとしてaspellを指定
(setq-default ispell-program-name "aspell")
;; 日本語混じりのTeX文書でスペルチェック
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; ユーザー辞書の定義
(setq ispell-personal-dictionary "~/.aspell.en.pws")


;;=====================================================================
;; zsh 関連

;;multi-term
(require 'multi-term)
(setq multi-term-program shell-file-name)
(add-hook 'term-mode-hook '(lambda ()
			     (define-key term-raw-map "\C-y" 'term-paste)
			     (define-key term-raw-map "\C-q" 'move-beginning-of-line)
			     (define-key term-raw-map "\C-f" 'forward-char)
			     (define-key term-raw-map "\C-b" 'backward-char)
			     (define-key term-raw-map "\C-t" 'set-mark-command)
			     (define-key term-raw-map (kbd "ESC") 'term-send-raw)
			     (define-key term-raw-map [delete] 'term-send-raw)
                             (define-key term-raw-map "\C-z"
                               (lookup-key (current-global-map) "\C-z"))))
(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)

(set-language-environment  'utf-8)
(set-default-coding-systems 'utf-8)

(require 'ucs-normalize)
(setq file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)
(setq system-uses-terminfo nil)

;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

(require 'multi-term)
(setq multi-term-program "/usr/local/bin/zsh-4.3.17")
(setenv "TERMINFO" "~/.terminfo")
;;======================================================================

;;magit
(add-to-list 'load-path "~/lisp/magit/share/emacs/site-lisp/")
(require 'magit)

(require 'anything-config)

;;--------------------------------------------------------------------------
;; Cocoa Emacsでバックスラッシュが上手く入力出来ない対策
;;
;;   MacなEmacsでバックスラッシュを簡単に入力したい - Watsonのメモ
;;   http://d.hatena.ne.jp/Watson/20100207/1265476938
;;
;;   Carbon Emacs で「\(バックスラッシュ)」を入力する - あいぷらぷら；
;;   http://d.hatena.ne.jp/june29/20080204/1202119521
;;--------------------------------------------------------------------------
;;(define-key global-map [?\¥] [?\\])
;;(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;;======================================================================
;; windows.el
;;======================================================================n
(defvar win:switch-prefix "\C-z")
(require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
;; C-x C-c で終了するとそのときのウィンドウの状態を保存する
;; C-x C なら保存しない
(define-key ctl-x-map "\C-c" 'see-you-again)
(define-key ctl-x-map "C" 'save-buffers-kill-emacs)
(define-key global-map "\C-c\C-r" 'resume-windows)

;; キーバインド C-z にを変更。デフォルトは C-c C-w。
;; 変更しない場合は，以下の 3 行を削除する。
;;C-z n   前のウィンドウ
;;C-z p   後のウィンドウ
;;C-z !   現在のウィンドウを破棄
;;C-z C-m メニューの表示
;;C-z ;   ウィンドウの一覧を表示




;;cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; そのままだと C-x が切り取りになってしまったりするので無効化

;;======================================================================
;; elscreen
;; ref http://www.morishima.net/~naoto/elscreen-ja/
;; ref http://d.hatena.ne.jp/rakudaininja/20090316/p1
;; apel http://git.chise.org/elisp/dist/semi/
;;======================================================================

;load "elscreen" "ElScreen" t)
;
;
;;; タブを表示(非表示にする場合は nil を設定する)
;(setq elscreen-display-tab t)
;
;;; 自動でスクリーンを作成
;(defmacro elscreen-create-automatically (ad-do-it)
;  `(if (not (elscreen-one-screen-p))
;       ,ad-do-it
;     (elscreen-create)
;     (elscreen-notify-screen-modification 'force-immediately)
;     (elscreen-message "New screen is automatically created")))
;
;(defadvice elscreen-next (around elscreen-create-automatically activate)
;  (elscreen-create-automatically ad-do-it))
;
;(defadvice elscreen-previous (around elscreen-create-automatically activate)
;  (elscreen-create-automatically ad-do-it))
;
;(defadvice elscreen-toggle (around elscreen-create-automatically activate)
;  (elscreen-create-automatically ad-do-it))
;
;;; タブ移動を簡単に
;(define-key global-map (kbd "M-t") 'elscreen-next)
;
;; frame-titleにスクリーンの一覧を表示する
;; (defun elscreen-frame-title-update ()
;;   (when (elscreen-screen-modified-p 'elscreen-frame-title-update)
;;     (let* ((screen-list (sort (elscreen-get-screen-list) '<))
;;        (screen-to-name-alist (elscreen-get-screen-to-name-alist))
;;        (title (mapconcat
;;            (lambda (screen)
;;              (format "%d%s %s"
;;                  screen (elscreen-status-label screen)
;;                  (get-alist screen screen-to-name-alist)))
;;            screen-list " ")))
;;       (if (fboundp 'set-frame-name)
;;       (set-frame-name title)
;;     (setq frame-title-format title)))))

;; (eval-after-load "elscreen"
;;   '(add-hook 'elscreen-screen-update-hook 'elscreen-frame-title-update))



;================================================================
;jaspace -> whitespace-modeにした
;================================================================
;(add-to-list 'load-path "~/.emacs.d")
;(require 'jaspace)
;; 全角空白を表示させる
;(setq jaspace-alternate-jaspace-string "□")
;; 改行記号を表示させる
;(setq jaspace-alternate-eol-string "↓\n")
;; タブを表示
;(setq jaspace-highlight-tabs t)
;; フック
;(add-hook 'yatex-mode-hook 'jaspace-mode)

;;whitespace-mode設定
(when (and (>= emacs-major-version 23)
	   (require 'whitespace nil t))
  (setq whitespace-style
	'(face
	  tabs spaces newline trailing space-before-tab space-after-tab
	  space-mark tab-mark newline-mark))
  (let ((dark (eq 'dark (frame-parameter nil 'background-mode))))
    (set-face-attribute 'whitespace-space nil
			:foreground (if dark "pink4" "azure3")
			:background 'unspecified)
    (set-face-attribute 'whitespace-tab nil
			:foreground (if dark "gray20" "gray80")
			:background 'unspecified
			:strike-through t)
    (set-face-attribute 'whitespace-newline nil
			:foreground (if dark "darkcyan" "darkseagreen")))
  (setq whitespace-space-regexp "\\(　+\\)")
  (set-face-bold-p 'whitespace-space t)
  (setq whitespace-display-mappings
	'((space-mark   ?\xA0  [?\xA4]  [?_]) ; hard space - currency
	  (space-mark   ?\x8A0 [?\x8A4] [?_]) ; hard space - currency
	  (space-mark   ?\x920 [?\x924] [?_]) ; hard space - currency
	  (space-mark   ?\xE20 [?\xE24] [?_]) ; hard space - currency
	  (space-mark   ?\xF20 [?\xF24] [?_]) ; hard space - currency
	  (space-mark   ?　    [?□]    [?＿]) ; full-width space - square
	  (newline-mark ?\n    [?\xAB ?\n])   ; eol - right quote mark
	  ))
  (setq whitespace-global-modes '(not dired-mode tar-mode))
  (global-whitespace-mode 1))

;================================================================
; YaTeX
;================================================================
;; YaTeX-mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
(setq auto-mode-alist
(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;;(setq dvi2-command "open -a TeXShop"
;;      tex-command "~/Library/TeXShop/bin/platex2pdf-utf8"
;;      YaTeX-kanji-code nil)

;;(setq dvi2-command "open -a TeXShop"
;;      tex-command "/usr/texbin/platex -kanji=utf8"
;;      YaTeX-kanji-code nil
;;      YaTeX-use-LaTeX2e t)


(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/opt/local/bin"
              "/smagiw/bin"
              "/usr/local/bin"
              "/usr/texbin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))

(setq tex-command "/usr/texbin/platex2pdf-utf8"
      ;;dviprint-command-format "/usr/texbin/dvipdfmx %s"
      dvi2-command "open -a TeXShop"
      YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-kanji-code 4)
;; bibtexコマンドの設定
(setq bibtex-command "/usr/texbin/pbibtex")

;;(setq YaTeX-dvi2-command-ext-alist nil)
; dvi2-commandで自動的に拡張子を補完してくれるようにする設定
;;(setq YaTeX-dvi2-command-ext-alist
;;  '(("xdvi\\|dvipdfmx" . ".dvi")
;;    ("ghostview\\|gv" . ".ps")
;;    ("acroread\\|pdf\\|Preview\\|TeXShop" . ".pdf")))
;;
(setq YaTeX-inhibit-prefix-letter t)

 ;; PATH と exec-path に同じ物を追加します
 (when (and (file-exists-p dir) (not (member dir exec-path)))
   (setenv "PATH" (concat dir ":" (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path))))
;(setq tex-command "~/Library/TeXShop/bin/platex2pdf-utf8" dvi2-command "open -a TexShop")
;(setq YaTeX-inhibit-prefix-letter t)
;(setq tex-command "platex")
;(defvar YaTeX-dvi2-command-ext-alist
;  '(("xdvi" . ".dvi")
;    ("ghostview¥¥|gv" . ".ps")
;    ("acroread¥¥|pdf¥¥|Preview¥¥|TeXShop¥¥|Skim" . ".pdf")))

;; YaHtml-mode
(setq auto-mode-alist
(cons (cons "\\.html$" 'yahtml-mode) auto-mode-alist))
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
(setq yahtml-www-browser "firefox")
; Ctrl-l で YaTeX の色付けが落ちるのを回避する
(defun font-lock-recenter ()
(interactive)
(font-lock-fontify-buffer)
(recenter))
;(global-set-key "\C-l" 'font-lock-recenter)
(add-hook 'yatex-mode-hook
'(lambda()
(progn
;; C-lで色付けが落ちるの対策
(define-key YaTeX-mode-map "\C-l"
'font-lock-recenter)
)))
; YaTeX ショートカットの変更・設定
;;(setq yatex-mode-load-hook
;;'(lambda()
;; (YaTeX-define-begend-key "be" "eqnarray")
;; (YaTeX-define-begend-key "be" "enumerate")
;; (YaTeX-define-begend-key "bt" "tabular")
;; (YaTeX-define-begend-key "bf" "figure")
;; (YaTeX-define-begend-key "ba" "align")2
;;)
;;)

;;=============================================================
;;auto-complete-mode用
;;=============================================================
;;(add-to-list 'load-path "~/.emacs.d")
(setq ac-dictionary-directories "~/.emacs.d/ac-dict/")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop)

;;=============================================================
;;auto-complete-mode for latex
;;=============================================================
(require 'auto-complete-latex)
(setq ac-l-dict-directory "~/.emacs.d/ac-l-dict/")
(add-to-list 'ac-modes 'yatex-mode)
(add-hook 'yatex-mode-hook 'ac-l-setup)

;;===============================================================
;;nXML mode/auto-complete
;;===============================================================
(add-to-list 'load-path "~/.emacs.d/html5-el/")
(eval-after-load "rng-loc"
   '(add-to-list 'rng-schema-locating-files "~/.emacs.d/html5-el/schemas.xml"))
(require 'whattf-dt)
(add-to-list 'ac-modes 'nxml-mode)
(setq ac-delay 0.1)

(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(setq auto-mode-alist
      (append '(
                ;;("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . xml-mode)
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . nxml-mode)
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))

(load "rng-auto.el" 't)
(add-hook 'nxml-mode-hook
          (lambda ()
            ;; 更新タイムスタンプの自動挿入
            (setq time-stamp-line-limit 10000)
            (if (not (memq 'time-stamp write-file-hooks))
                (setq write-file-hooks
                      (cons 'time-stamp write-file-hooks)))
            (setq time-stamp-format "%3a %3b %02d %02H:%02M:%02S %:y %Z")
            (setq time-stamp-start "Last modified:[ \t]")
            (setq time-stamp-end "$")
            ;;
            (setq auto-fill-mode -1)
            (setq nxml-slash-auto-complete-flag t)      ; スラッシュの入力で終了タグを自動補完
            (setq nxml-child-indent 2)                  ; タグのインデント幅
            (setq nxml-attribute-indent 4)              ; 属性のインデント幅
            (setq indent-tabs-mode t)
            (setq nxml-bind-meta-tab-to-complete-flag t)
            (setq nxml-slash-auto-complete-flag t)      ; </の入力で閉じタグを補完する
            (setq nxml-sexp-element-flag t)             ; C-M-kで下位を含む要素全体をkillする
            (setq nxml-char-ref-display-glyph-flag nil) ; グリフは非表示
            (setq tab-width 4)))

(setq auto-mode-alist
      (append '(
                ;;("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . xml-mode)
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . nxml-mode)
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))

(load "rng-auto.el" 't)
(add-hook 'nxml-mode-hook
          (lambda ()
            ;; 更新タイムスタンプの自動挿入
            (setq time-stamp-line-limit 10000)
            (if (not (memq 'time-stamp write-file-hooks))
                (setq write-file-hooks
                      (cons 'time-stamp write-file-hooks)))
            (setq time-stamp-format "%3a %3b %02d %02H:%02M:%02S %:y %Z")
            (setq time-stamp-start "Last modified:[ \t]")
            (setq time-stamp-end "$")
            ;;
            (setq auto-fill-mode -1)
            (setq nxml-slash-auto-complete-flag t)      ; スラッシュの入力で終了タグを自動補完
            (setq nxml-child-indent 2)                  ; タグのインデント幅
            (setq nxml-attribute-indent 4)              ; 属性のインデント幅
            (setq indent-tabs-mode t)
            (setq nxml-bind-meta-tab-to-complete-flag t)
            (setq nxml-slash-auto-complete-flag t)      ; </の入力で閉じタグを補完する
            (setq nxml-sexp-element-flag t)             ; C-M-kで下位を含む要素全体をkillする
            (setq nxml-char-ref-display-glyph-flag nil) ; グリフは非表示
            (setq tab-width 4)))

(custom-set-faces
 '(nxml-comment-content-face
   ((t (:foreground "red"))))                            ; コメント
 '(nxml-comment-delimiter-face
   ((t (:foreground "red"))))                            ; ＜!-- --＞
 '(nxml-delimited-data-face
   ((t (:foreground "DarkViolet"))))                     ; 属性値やDTD引数値など
 '(nxml-delimiter-face
   ((t (:foreground "blue"))))                           ; ＜＞ ＜? ?＞ ""
 '(nxml-element-local-name-face
   ((t (:inherit nxml-name-face :foreground "blue"))))   ; 要素名
 '(nxml-name-face
   ((t (:foreground "dark green"))))                     ; 属性名など
 '(nxml-element-colon-face
   ((t (:foreground "LightSteelBlue"))))                 ; :(xsl:paramなど)
 '(nxml-ref-face
   ((t (:foreground "DarkGoldenrod"))))                  ; ＆lt;など
 '(nxml-tag-slash-face
   ((t (:inherit nxml-name-face :foreground "blue")))))  ; /(終了タグ)

;;==========================================================================
;;括弧の自動挿入
;;==========================================================================
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
;;(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;;======================================================================
;;auto-install.el
;;======================================================================
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保

;;========================================================================
;;LaTeX indent
;;========================================================================
 (autoload 'latex-indent-command "~/.emacs.d/latex-indent"
   "Indent current line accroding to LaTeX block structure.")
 (autoload 'latex-indent-region-command "~/.emacs.d/latex-indent"
   "Indent each line in the region according to LaTeX block structure.")
 (add-hook
  'latex-mode-hook
  '(lambda ()
     (define-key tex-mode-map "\t"       'latex-indent-command)
     ;;(define-key tex-mode-map "\C-m" 'latex-indent-command)
     (define-key tex-mode-map "\M-\C-\\" 'latex-indent-region-command)))

;;=============================================================
;;color-moccur設定 emacs実践入門より
;;=============================================================
(when(require 'color-moccur nil t)
;;M-oにcolor-by-moccur割当
(define-key global-map (kbd "M-o") 'occur-by-moccur)
;;スペース区切りでAND検索
(setq moccr-split-word t)
;;ディレクトリ検索時に除外
(add-to-list 'dmoccur-exclusion-mask "\\.DS_store")
(add-to-list 'dmoccur-exclusion-mask "^#.+#$")

;;MIgemo
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
(setq moccur-use-migemo t)))

;;ついでにmoccur-editも
(require 'moccur-edit)

;;======================================================================
;; revive.el
;;======================================================================
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(add-hook 'kill-emacs-hook 'save-current-configuration)   ; 終了時に保存
(resume-windows 0) ; 起動時に復元
