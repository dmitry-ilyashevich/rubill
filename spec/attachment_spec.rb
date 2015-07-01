require "spec_helper"

module Rubill
  describe Attachment do
    let(:options) { { "a" => "b" } }

    describe ".send_attachment" do
      let(:id) { "123" }
      let(:file_name) { "file.txt" }

      context "with plain text" do
        before do
          expect(Query).to receive(:upload_attachment).with({
            data: {
              id: id,
              fileName: file_name,
              document: "VGVzdCB0ZXh0"
            }
          })
        end

        it "should be encoded" do
          described_class.send_attachment(id, file_name, 'Test text')
        end
      end

      context "with base64 encoded string" do
        let(:content) { "QW5vdGhlciB0ZXN0IHRleHQ=" }

        before do
          expect(Query).to receive(:upload_attachment).with({
            data: {
              id: id,
              fileName: file_name,
              document: content
            }
          })
        end

        it "should not be encoded" do
          described_class.send_attachment(id, file_name, content)
        end
      end
    end
  end
end
